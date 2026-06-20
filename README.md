# type-simulator

> 🇫🇷 Français | 🇬🇧 English

---

## 🇫🇷 Français

### Description

**type-simulator** est un outil Windows qui simule la frappe clavier au niveau système, en injectant des touches directement via l'API Windows (`SendInput`). Il est conçu pour saisir du texte dans des champs qui bloquent le copier-coller (formulaires web restrictifs, applications sécurisées, etc.).

### Fichiers

| Fichier | Description |
|---|---|
| `type_simulator.ps1` | Script principal PowerShell — injection clavier via `SendInput` |
| `type_simulator.bat` | Lanceur — exécute le script PS1 en contournant la politique d'exécution |

### Utilisation

1. Modifier `type_simulator.ps1` et remplacer le texte dans la variable `$text` par le texte à saisir.
2. Double-cliquer sur `type_simulator.bat` pour lancer.
3. Cliquer **OK** dans la popup, puis cliquer dans le champ cible.
4. La frappe démarre automatiquement après un compte à rebours de **3 secondes**.

### Prérequis

- Windows 10 / 11
- PowerShell 5.1 ou supérieur (inclus par défaut)
- Aucune installation requise

### Avertissement

Ce script injecte des frappes clavier au niveau système. Utilisez-le uniquement sur votre propre machine et dans un cadre légal.

---

## 🇬🇧 English

### Description

**type-simulator** is a Windows tool that simulates keyboard input at the system level, injecting keystrokes directly through the Windows API (`SendInput`). It is designed to type text into fields that block copy-paste (restrictive web forms, secured applications, etc.).

### Files

| File | Description |
|---|---|
| `type_simulator.ps1` | Main PowerShell script — keyboard injection via `SendInput` |
| `type_simulator.bat` | Launcher — runs the PS1 script bypassing the execution policy |

### Usage

1. Edit `type_simulator.ps1` and replace the text in the `$text` variable with the text you want to type.
2. Double-click `type_simulator.bat` to launch.
3. Click **OK** in the popup, then click inside the target field.
4. Typing starts automatically after a **3-second** countdown.

### Requirements

- Windows 10 / 11
- PowerShell 5.1 or higher (included by default)
- No installation required

### Disclaimer

This script injects keystrokes at the system level. Use it only on your own machine and within a legal context.

---

*Made by [JamesInvaderbdx](https://github.com/JamesInvaderbdx)*
