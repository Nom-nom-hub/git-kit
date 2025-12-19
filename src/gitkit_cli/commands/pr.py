import typer
import shutil
import re
from pathlib import Path
from rich.console import Console

app = typer.Typer()
console = Console()

@app.command()
def create(name: str):
    """
    Plan a new Pull Request.
    """
    slug = re.sub(r'[^a-zA-Z0-9-]', '-', name.lower()).strip('-')
    filename = f"{slug}.md"
    
    src = Path(".github") / "pr-template.md"
    dest = Path(".github") / "pr-plans" / filename
    
    if not src.exists():
        console.print("[red]Error: Template .github/pr-template.md not found. Run `git-kit init` first.[/red]")
        raise typer.Exit(1)
        
    if dest.exists():
        console.print(f"[yellow]Plan {dest} already exists.[/yellow]")
        return

    shutil.copy2(src, dest)
    console.print(f"[green]Created PR Plan:[/green] {dest}")
    console.print("Now edit the file to define your PR implementation steps.")
