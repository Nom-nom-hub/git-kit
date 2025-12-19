import typer
import shutil
from pathlib import Path
from rich.console import Console

app = typer.Typer()
console = Console()

@app.command()
def create(version: str):
    """
    Plan a new Release.
    """
    filename = f"{version}.md"
    
    src = Path(".github") / "release-plan.md"
    dest = Path(".github") / "releases" / filename
    
    if not src.exists():
        console.print("[red]Error: Template .github/release-plan.md not found. Run `git-kit init` first.[/red]")
        raise typer.Exit(1)
        
    if dest.exists():
        console.print(f"[yellow]Release Plan {dest} already exists.[/yellow]")
        return

    shutil.copy2(src, dest)
    console.print(f"[green]Created Release Plan:[/green] {dest}")
