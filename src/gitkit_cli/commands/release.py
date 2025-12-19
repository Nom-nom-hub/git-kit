import typer
import shutil
from pathlib import Path
from rich.console import Console

app = typer.Typer()
console = Console()

@app.command()
def create(
    version: str,
    path: Path = typer.Argument(".", help="Project root")
):
    """
    Plan a new Release.
    """
    filename = f"{version}.md"
    
    src = path / ".github" / "templates" / "release.md"
    dest = path / ".github" / "releases" / filename
    
    if not src.exists():
        console.print(f"[red]Error: Template {src} not found. Run `git-kit init` first.[/red]")
        raise typer.Exit(1)
        
    if dest.exists():
        console.print(f"[yellow]Release Plan {dest} already exists.[/yellow]")
        return

    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest)
    console.print(f"[green]Created Release Plan:[/green] {dest}")
