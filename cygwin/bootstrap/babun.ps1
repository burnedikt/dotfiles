Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    Param(
        [parameter(Mandatory=$true)]
        [string]
        $zipfile,
        [parameter(Mandatory=$true)]
        [string]
        $outpath
    )

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function Download-File
{
    Param(
        [parameter(Mandatory=$true)]
        [String]
        $url,
        [parameter(Mandatory=$true)]
        [String]
        $outpath
    )

    Write-Output "Starting download of $url"
    $start_time = Get-Date
    # one-liner for download using .net webclient
    (New-Object System.Net.WebClient).DownloadFile($url, $outpath)
    Write-Output "Wrote file from $url to $outpath"
    Write-Output "Time for Download: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}

function Install-Babun
{
    Param(
        [parameter(Mandatory=$true)]
        [String]
        $version
    )
    $urlBase = "http://projects.reficio.org/babun/download"
    $fileName = "$env:tmp\babun-$version-dist.zip"
    $tmpDest = "$env:tmp\babun"

    # Download and unblock the zip file
    Download-File $urlBase $fileName
    Unblock-File $fileName

    # Create a temporary directory to unzip babun to
    New-Item -ItemType Directory -Force -Path $tmpDest

    # Unpack the zip file to the temp dir
    Unzip $fileName $tmpDest

    # Run the install batch file
    cmd.exe /c "$tmpDest\babun-$version\install.bat"

    # remove unzip folder and downloaded file
    Remove-Item -Path $tmpDest -Recurse
    Remove-Item $fileName
}

# check if babun is already installed
$babun=Get-Command babun
if (!$?) {
    Write-Warning "Babun not found. Installing..."
    # actually run the installer
    Install-Babun "1.2.0"
} else {
    Write-Output "Babun is already installed. Nothing to do here"
}
