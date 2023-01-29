[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$servers = @("Server1", "Server2", "Server3")

$form = New-Object System.Windows.Forms.Form
$form.Width = 300
$form.Height = 200
$form.Text = "Server Selection"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Select a server:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,10)
$form.Controls.Add($label)

$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(10,30)
$comboBox.Width = 260
$comboBox.Height = 20
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

foreach ($server in $servers) {
    $comboBox.Items.Add($server)
}

$form.Controls.Add($comboBox)

$button = New-Object System.Windows.Forms.Button
$button.Text = "Connect"
$button.Width = 100
$button.Height = 30
$button.Location = New-Object System.Drawing.Point(10,60)
$form.Controls.Add($button)

$button.Add_Click({
    $selectedServer = $comboBox.SelectedItem
    Connect-VIServer -Server $selectedServer
    $clusters = Get-Cluster
    $form.Close()

    $clusterForm = New-Object System.Windows.Forms.Form
    $clusterForm.Width = 300
    $clusterForm.Height = 200
    $clusterForm.Text = "Cluster List"

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10,10)
    $listBox.Width = 260
    $listBox.Height = 120

    foreach ($cluster in $clusters) {
        $listBox.Items.Add($cluster.Name)
    }

    $clusterForm.Controls.Add($listBox)

    $clusterForm.ShowDialog()
})

$form.ShowDialog()
