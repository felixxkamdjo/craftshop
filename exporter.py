import sqlite3

def export_db():
    conn = sqlite3.connect("projet.db")
    with open("export_projet.sql", "w", encoding="utf-8") as f:
        for line in conn.iterdump():
            f.write(f"{line}\n")
    conn.close()
    print("Export SQL généré dans export_projet.sql.")

if __name__ == "__main__":
    export_db()
