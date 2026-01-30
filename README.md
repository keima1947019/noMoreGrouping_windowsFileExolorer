# Fix-Windows11-ExplorerBehavior

Force classic and consistent File Explorer behavior on Windows 11.

This PowerShell script permanently enforces a predictable Explorer UI by:
- Restoring the classic right-click context menu
- Disabling folder grouping for all folders (including existing ones)
- Forcing a unified folder view mode
- Making the configuration resilient against Windows Update resets

---

## ✨ Features

- ✅ Restore **classic context menu**  
  (Skip “Show more options” in Windows 11)

- ✅ **Disable “Group by” globally**  
  Applies to *all existing and future folders*

- ✅ **Force Explorer view mode**
  - Default: **Details view**
  - Easily customizable (Large icons, List, etc.)

- ✅ **Windows Update–resistant**
  - Fully resets and redefines Explorer Bags / BagMRU
  - Overrides folder templates (Documents, Pictures, Music, Videos)

---

## 🧠 Why this exists

Windows 11 frequently:
- Re-enables folder grouping automatically
- Changes view modes per folder type
- Resets Explorer UI settings after updates

This script enforces **human-defined defaults**, not Microsoft’s adaptive guesses.

---

## 🛠 Requirements

- Windows 11
- PowerShell 5.1 or later
- User context (HKCU)
- **Administrator privileges recommended**

> No external modules required.

---

## 🚀 Usage

1. Clone or download this repository
2. Open **PowerShell** (Run as Administrator recommended)
3. Execute the script:

```powershell
.\Fix-Windows11-ExplorerBehavior.ps1
