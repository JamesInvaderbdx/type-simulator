Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class KeySender {
    [DllImport("user32.dll", SetLastError=true)]
    static extern uint SendInput(uint n, INPUT[] inputs, int size);
    [DllImport("user32.dll")]
    static extern short VkKeyScan(char ch);

    [StructLayout(LayoutKind.Sequential)]
    struct INPUT { public uint type; public Union u; }
    [StructLayout(LayoutKind.Explicit)]
    struct Union {
        [FieldOffset(0)] public MOUSE mi;
        [FieldOffset(0)] public KEYBD ki;
        [FieldOffset(0)] public HARD  hi;
    }
    [StructLayout(LayoutKind.Sequential)]
    struct MOUSE  { public int dx,dy; public uint data,flags,time; public IntPtr extra; }
    [StructLayout(LayoutKind.Sequential)]
    struct KEYBD  { public ushort vk,scan; public uint flags,time; public IntPtr extra; }
    [StructLayout(LayoutKind.Sequential)]
    struct HARD   { public uint msg; public ushort lo,hi; }

    static int SZ = 0;

    static INPUT K(ushort vk, ushort sc, uint fl) {
        INPUT i = new INPUT(); i.type = 1;
        i.u.ki.vk = vk; i.u.ki.scan = sc; i.u.ki.flags = fl;
        return i;
    }

    static void Send(INPUT[] arr) {
        if (SZ == 0) SZ = Marshal.SizeOf(typeof(INPUT));
        SendInput((uint)arr.Length, arr, SZ);
    }

    public static void Type(string text, int delayMs) {
        foreach (char c in text) {
            short vk = VkKeyScan(c);
            if (vk == -1) {
                Send(new[] { K(0,(ushort)c,0x0004), K(0,(ushort)c,0x0006) });
            } else {
                byte code  = (byte)(vk & 0xFF);
                byte shift = (byte)((vk >> 8) & 0xFF);
                bool sh = (shift & 1) != 0;
                bool ct = (shift & 2) != 0;
                bool al = (shift & 4) != 0;
                if (sh) Send(new[] { K(0x10,0,0) });
                if (ct) Send(new[] { K(0x11,0,0) });
                if (al) Send(new[] { K(0x12,0,0) });
                Send(new[] { K(code,0,0), K(code,0,0x0002) });
                if (al) Send(new[] { K(0x12,0,0x0002) });
                if (ct) Send(new[] { K(0x11,0,0x0002) });
                if (sh) Send(new[] { K(0x10,0,0x0002) });
            }
            System.Threading.Thread.Sleep(delayMs);
        }
    }
}
"@

# --- Popup d'instruction ---
$result = [System.Windows.Forms.MessageBox]::Show(
    "Cliquez OK, puis cliquez dans le champ cible.`nLa frappe commencera dans 3 secondes.",
    "type_journal",
    [System.Windows.Forms.MessageBoxButtons]::OKCancel,
    [System.Windows.Forms.MessageBoxIcon]::Information
)
if ($result -ne [System.Windows.Forms.DialogResult]::OK) { exit }

# --- Compte a rebours ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Frappe dans..."
$form.Size = New-Object System.Drawing.Size(200, 130)
$form.TopMost = $true
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedToolWindow"
$form.ControlBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Dock = "Fill"
$label.TextAlign = "MiddleCenter"
$label.Font = New-Object System.Drawing.Font("Arial", 48, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($label)

$script:count = 3
$label.Text = $script:count

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    $script:count--
    if ($script:count -le 0) {
        $timer.Stop()
        $form.Close()
    } else {
        $label.Text = $script:count
    }
})
$timer.Start()
$form.ShowDialog() | Out-Null

# --- Texte a taper ---
# Remplacer ci-dessous par le texte a saisir (ou lire depuis un fichier .txt)
$text = @"
[Insérer ici le texte à saisir]
"@

[KeySender]::Type($text, 40)
