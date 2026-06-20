# type-simulator

> 🇫🇷 Français | 🇬🇧 English

---

## 🇫🇷 Français

Simule la saisie clavier caractère par caractère en utilisant l'API Windows `SendInput`.

Utile quand un champ texte bloque le copier-coller (presse-papiers désactivé, clic droit verrouillé, ou le champ intercepte les événements de collage). Au lieu de coller, le script tape le texte comme si vous appuyiez sur chaque touche manuellement.

### Comment ça fonctionne

1. Lancer `type_simulator.bat` (ou `type_simulator.ps1` directement)
2. Cliquer **OK** sur la popup
3. Cliquer dans le champ texte cible
4. Un compte à rebours de 3 secondes s'affiche — le script commence à taper automatiquement quand il atteint zéro

### Utilisation

#### Démarrage rapide

Double-cliquer sur `type_simulator.bat`.

#### Modifier le texte à saisir

Ouvrir `type_simulator.ps1` et remplacer le placeholder en bas du fichier :

```powershell
$text = @"
[Insérer ici le texte à saisir]
"@
```

#### Charger le texte depuis un fichier

Remplacer le bloc `$text` par :

```powershell
$text = Get-Content "C:\chemin\vers\votre\fichier.txt" -Raw
```

#### Ajuster la vitesse de frappe

Modifier le délai (en millisecondes) dans la dernière ligne :

```powershell
[KeySender]::Type($text, 40)   # 40 ms entre chaque caractère
```

Plus faible = plus rapide, plus élevé = plus humain.

### Fichiers

| Fichier | Description |
|---|---|
| `type_simulator.ps1` | Script principal PowerShell — injection clavier via `SendInput` |
| `type_simulator.bat` | Lanceur — exécute le script PS1 en contournant la politique d'exécution |

### Prérequis

- Windows 10 / 11
- PowerShell 5.1 ou supérieur (inclus avec Windows)

### Notes

- Fonctionne avec les caractères accentués et la plupart des caractères Unicode via le flag `KEYEVENTF_UNICODE`
- Ne nécessite pas de privilèges administrateur
- La fenêtre du script reste au premier plan pendant le compte à rebours pour que vous puissiez basculer vers l'application cible

### Avertissement

Ce script injecte des frappes clavier au niveau système. Utilisez-le uniquement sur votre propre machine et dans un cadre légal.

---

## 🇬🇧 English

Simulates keyboard input character by character using the Windows `SendInput` API.

Useful when a text field blocks copy-paste (clipboard is disabled, right-click is locked, or the field intercepts paste events). Instead of pasting, the script types the text as if you were pressing each key manually.

### How it works

1. Run `type_simulator.bat` (or `type_simulator.ps1` directly)
2. Click **OK** on the prompt
3. Click inside the target text field
4. A 3-second countdown appears — the script starts typing automatically when it reaches zero

### Usage

#### Quick start

Double-click `type_simulator.bat`.

#### Edit the text to type

Open `type_simulator.ps1` and replace the placeholder at the bottom:

```powershell
$text = @"
[Insert text to type here]
"@
```

#### Load text from a file

Replace the `$text` block with:

```powershell
$text = Get-Content "C:\path\to\your\file.txt" -Raw
```

#### Adjust typing speed

Change the delay (in milliseconds) in the last line:

```powershell
[KeySender]::Type($text, 40)   # 40 ms between each character
```

Lower = faster, higher = more human-like.

### Files

| File | Description |
|---|---|
| `type_simulator.ps1` | Main PowerShell script — keyboard injection via `SendInput` |
| `type_simulator.bat` | Launcher — runs the PS1 script bypassing the execution policy |

### Requirements

- Windows 10 or 11
- PowerShell 5.1+ (included with Windows)

### Notes

- Works with accented characters and most Unicode via the `KEYEVENTF_UNICODE` flag
- Does not require administrator privileges
- The script window stays on top during the countdown so you can switch to the target app

### Disclaimer

This script injects keystrokes at the system level. Use it only on your own machine and within a legal context.

---

*Made by [JamesInvaderbdx](https://github.com/JamesInvaderbdx)*
