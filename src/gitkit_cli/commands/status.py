import typer
from rich.console import Console
from rich.table import Table
from pathlib import Path

app = typer.Typer()
console = Console()

@app.command()
def main():
    """Show the status of your Git-Kit project (Plans, Releases, Designs)."""
    
    github_dir = Path(".github")
    if not github_dir.exists():
        console.print("[yellow]No .github directory found. Run `git-kit init` first.[/yellow]")
        return

    # 1. PR Plans
    pr_plans = list((github_dir / "pr-plans").glob("*.md"))
    if pr_plans:
        table = Table(title="[bold blue]Open PR Plans[/bold blue]")
        table.add_column("File", style="cyan")
        table.add_column("Status", style="green")
        
        for plan in pr_plans:
             # Simple heuristic: check if file has "Status: Draft" or similar? 
             # For now just list them.
             table.add_row(plan.name, "Active")
        console.print(table)
        console.print()
    else:
        console.print("[dim]No active PR Plans.[/dim]")

    # 2. Releases
    releases = list((github_dir / "releases").glob("*.md"))
    if releases:
        table = Table(title="[bold magenta]Release Plans[/bold magenta]")
        table.add_column("Version", style="magenta")
        table.add_column("State", style="white")
        
        for rel in releases:
            table.add_row(rel.name, "Planned")
        console.print(table)
        console.print()

    # 3. Designs
    designs = list((github_dir / "designs").glob("*.md"))
    if designs:
        table = Table(title="[bold yellow]Design Docs[/bold yellow]")
        table.add_column("Feature", style="yellow")
        
        for design in designs:
            table.add_row(design.name)
        console.print(table)
    
    if not (pr_plans or releases or designs):
        console.print("[dim]Project is clean. Run `git-kit pr` to start planning.[/dim]")
