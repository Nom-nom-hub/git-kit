import typer
from rich.console import Console
from rich.prompt import Prompt
import shutil
from pathlib import Path
import httpx
import zipfile
import io
import os

app = typer.Typer()
console = Console()

TEMPLATE_REPO = "Nom-nom-hub/git-kit"

def download_template(agent: str, script: str, path: Path) -> bool:
    """Downloads the specific agent/script template from GitHub Releases."""
    try:
        console.print(f"[cyan]Fetching latest release for {agent} ({script})...[/cyan]")
        api_url = f"https://api.github.com/repos/{TEMPLATE_REPO}/releases/latest"
        
        # 1. Get Release Info
        response = httpx.get(api_url, follow_redirects=True)
        if response.status_code != 200:
            console.print(f"[yellow]Could not fetch release info (Status {response.status_code}). Using local fallback if available.[/yellow]")
            return False
            
        release_data = response.json()
        version = release_data.get("tag_name", "latest")
        assets = release_data.get("assets", [])
        
        # 2. Find matching asset
        # Pattern: git-kit-template-{agent}-{script}-{version}.zip
        target_name_part = f"git-kit-template-{agent}-{script}-"
        download_url = None
        
        for asset in assets:
            if target_name_part in asset["name"] and asset["name"].endswith(".zip"):
                download_url = asset["browser_download_url"]
                break
        
        if not download_url:
            console.print(f"[red]Could not find asset matching '{target_name_part}' in release {version}.[/red]")
            return False
            
        # 3. Download
        console.print(f"[cyan]Downloading {download_url}...[/cyan]")
        zip_resp = httpx.get(download_url, follow_redirects=True)
        zip_resp.raise_for_status()
        
        # 4. Extract
        with zipfile.ZipFile(io.BytesIO(zip_resp.content)) as z:
            # The zip contains a folder `git-kit-template-.../git-kit/...`
            # We assume users want the CONTENTS of `git-kit/` in their root.
            z.extractall(path)
            
            extracted_roots = [f for f in path.iterdir() if f.is_dir() and "git-kit-template" in f.name]
            if extracted_roots:
                src_root = extracted_roots[0] / "git-kit"
                if src_root.exists():
                     shutil.copytree(src_root, path, dirs_exist_ok=True)
                     shutil.rmtree(extracted_roots[0])
        
        console.print(f"[green]Successfully initialized from release {version}![/green]")
        return True
        
    except Exception as e:
        console.print(f"[red]Download failed: {e}[/red]")
        return False

@app.command()
def main(
    path: Path = typer.Argument(".", help="Project root to initialize"),
    agent: str = typer.Option(None, "--agent", help="AI Assistant (claude, gemini, etc)"),
    script: str = typer.Option(None, "--script", help="Script type (sh, ps)"),
    local: bool = typer.Option(False, "--local", help="Force use of local templates (skip download)")
):
    """
    Initialize Git-Kit in the specified repository path.
    Downloads the appropriate templates for your Agent and Shell.
    """
    console.print("[bold blue]Git-Kit Initialization[/bold blue]")
    
    # 1. Prompt for Agent and Script
    if not agent:
        agent = Prompt.ask(
            "Select your AI Assistant", 
            choices=["claude", "gemini", "copilot", "cursor", "qwen", "windsurf", "opencode", "codex", "kilocode", "auggie", "codebuddy", "roo", "q"],
            default="claude"
        )
        
    if not script:
        default_script = "ps" if os.name == "nt" else "sh"
        script = Prompt.ask(
            "Select your Shell Script type",
            choices=["sh", "ps"],
            default=default_script
        )

    # 2. Download or Local Fallback
    success = False
    if not local:
        success = download_template(agent, script, path)
    
    if not success:
        if not local:
            console.print("[yellow]Falling back to bundled templates...[/yellow]")
        
        # FALLBACK: Local Bundle Logic
        github_dir = path / ".github"
        github_dir.mkdir(exist_ok=True)
        
        # Path Finding (Dev vs Installed)
        TEMPLATE_DEV_ROOT = Path(__file__).parent.parent.parent.parent / "templates"
        if not TEMPLATE_DEV_ROOT.exists():
             TEMPLATE_DEV_ROOT = Path(__file__).parent / "templates"

        # Install Templates
        (github_dir / "pr-plans").mkdir(exist_ok=True)
        (github_dir / "releases").mkdir(exist_ok=True)
        (github_dir / "designs").mkdir(exist_ok=True)

        templates_to_install = {
            "pr-template.md": github_dir / "pr-template.md",
            "release-plan.md": github_dir / "release-plan.md",
            "release-notes.md": github_dir / "release-notes.md",
            "design-doc.md": github_dir / "design-doc.md",
            "repo-charter.md": github_dir / "CHARTER.md",
            "workflow-design.md": github_dir / "workflow-design.md"
        }

        for src_name, dest in templates_to_install.items():
            src = TEMPLATE_DEV_ROOT / src_name
            if not src.exists():
                src = path / "git-kit" / "templates" / src_name
            
            if not dest.exists() and src.exists():
                shutil.copy2(src, dest)
                console.print(f"  [green]✓[/green] Created {dest}")

        # Install Agent File
        agent_file_dest = path / f"{agent.upper()}.md"
        # Special naming
        if agent == "copilot":
             agent_file_dest = github_dir / "goal-kit-guide.md"
        elif agent == "vscode":
             agent_file_dest = Path("git-kit-instructions.md")

        agent_template = TEMPLATE_DEV_ROOT / "agent-file-template.md"
        if not agent_template.exists():
             agent_template = path / "git-kit" / "templates" / "agent-file-template.md"
             
        if agent_template.exists() and not agent_file_dest.exists():
            content = agent_template.read_text(encoding="utf-8")
            content = content.replace("[AGENT_NAME]", agent.upper())
            agent_file_dest.parent.mkdir(parents=True, exist_ok=True)
            agent_file_dest.write_text(content, encoding="utf-8")
            console.print(f"  [green]✓[/green] Created {agent_file_dest}")
            
        # Install Scripts
        scripts_dir = github_dir / "scripts"
        scripts_dir.mkdir(exist_ok=True)
        
        script_src_name = "bash" if script == "sh" else "powershell"
        script_ext = "*.sh" if script == "sh" else "*.ps1"
        
        script_src = TEMPLATE_DEV_ROOT.parent / "scripts" / script_src_name
        if not script_src.exists():
            script_src = path / "git-kit" / "scripts" / script_src_name
            
        target_script_dir = scripts_dir / script_src_name
        target_script_dir.mkdir(exist_ok=True)
        
        if script_src.exists():
            for s in script_src.glob(script_ext):
                shutil.copy2(s, target_script_dir / s.name)
                console.print(f"  [green]✓[/green] Installed {s.name}")

    console.print("\n[bold blue]Git-Kit Initialized![/bold blue]")
    console.print("Run `git-kit pr --help` to start planning.")
