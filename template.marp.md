---
marp: true
math: mathjax
title: Raport z projektu
size: 16:9
paginate: true
mermaid: true
transition: fade
theme: gaia
backgroundImage: url("page-background.png")
footer: "**Raport SJU**"
style: |
  @import url('https://unpkg.com/tailwindcss@^2/dist/utilities.min.css');
---

<!-- Strona tytułowa -->
<div class="flex flex-col items-center justify-center h-full text-center">
<img src="https://upload.wikimedia.org/wikipedia/commons/3/34/Logo_PolSl.svg" class="w-60" />
#### Raport z projektu
###### *Imię i nazwisko:* Maciej Musioł  
###### *Kierunek:* Teleinformatyka s.2  
###### *Semestr:* 1
</div>

---

# Etap 1: Repozytorium na GitHub

- Fork podanego repozytorium projektu.
- Uruchomienie repozytorium lokalnie w Visual Studio.
- Budowa obrazu Docker:
  ```bash
  docker build -t sjuprojekt .
- Uruchomienie kontenera i weryfikacja plików projektu
  ```bash
  docker run -it --rm -v .:/home/vscode/workspace sjuprojekt bash

---
# Etap 2: Modyfikacja Dockerfile
- Instalacja dodatkowych pakietów (curl, wget, git, ...) - bez tego kroku jeden z dalszych punktów nie działał poprawnie
- Instalacja wymaganych pakietów (qiskit, matplotlib, ...)
- Obraz ponownie zbudowany i przetestowany lokalnie.

---
# Etap 3: Kontener developerski
- Utworzenie pliku .devcontainer/devcontainer.json
```json
{
  "workspaceMount": "source=${localWorkspaceFolder},target=/home/vscode/workspace,type=bind,consistency=cached",
  "workspaceFolder": "/home/vscode/workspace",
  "name": "Projekt-SJU",
  "image": "ghcr.io/mm300907/projekt_sju:latest",
  "customizations": {
    "vscode": {
        "extensions": [
          "ms-python.python",
          "ms-toolsai.jupyter",
          "yzhang.markdown-all-in-one",
          "marp-team.marp-vscode",
          "github.vscode-github-actions"
        ]
    }
  },
  "postCreateCommand": "pip install --no-cache-dir -r requirements.txt && uname -a && python --version && pip --version",
  "remoteUser": "vscode"
}
```

---
# Etap 4: GitHub Actions – CI/CD
- Utworzono workflow docker-publish.yml.
- Zarejestrowano obraz Docker w ghcr.io.
- Dodano test importów (uruchamiany przed publikacją):
```python
def test_imports():
    packages = ["qiskit", "matplotlib", "PIL", "Cryptodome", "cryptography"] #wymagane pakiety do testu 
    for pkg in packages:
        try:
            __import__(pkg)
            print(f"✅ {pkg} - OK")
        except ImportError:
            print(f"❌ {pkg} - MISSING")
            exit(1)

if __name__ == "__main__":
    test_imports()
```

---
# Etap 5: Diagram Mermaid
![bg right fit, h:85%](doc\Mermaid.png)

---
# Etap 6: Praca z notatnikiem Jupyter
- Stworzono katalog sample/ z notatnikiem.
- Upewniono się, że wszystkie wymagane biblioteki są dostępne.
- Obraz ponownie otagowano i zaktualizowano wersję:
```json
"image": "ghcr.io/użytkownik/projekt_sju:latest"
```

---
# Podsumowanie
- Najtrudniejsze: Konfiguracja workflow GitHub Actions oraz poprawne testowanie pakietów.
- Nauczyłem się:
    - Obsługi Docker i Codespaces,
    - Tworzenia CI/CD z GitHub Actions,
    - Pracy z plikami .devcontainer, Dockerfile.

