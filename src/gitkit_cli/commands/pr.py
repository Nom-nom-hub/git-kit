import typer
import shutil
import re
from pathlib import Path
from rich.console import Console

app = typer.Typer()
console = Console()

@app.command()
def create(
    name: str,
    path: Path = typer.Argument(".", help="Project root")
):
    """
    Plan a new Pull Request.
    """
    slug = re.sub(r'[^a-zA-Z0-9-]', '-', name.lower()).strip('-')
    filename = f"{slug}.md"
    
    src = path / ".github" / "templates" / "pr.md"
    dest = path / ".github" / "pr-plans" / filename
    
    if not src.exists():
        console.print(f"[red]Error: Template {src} not found. Run `git-kit init` first.[/red]")
        raise typer.Exit(1)
        
    if dest.exists():
        console.print(f"[yellow]Plan {dest} already exists.[/yellow]")
        return

    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest)
    console.print(f"[green]Created PR Plan:[/green] {dest}")
    console.print("Now edit the file to define your PR implementation steps.")
