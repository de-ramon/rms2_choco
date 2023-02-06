<#
.SYNOPSIS
    This script creates a .xml-file containing the installed choco packages
    with their corresponding version numers
.DESCRIPTION
    This script creates a .xml-file containing the installed choco packages,
    which can be used to automate the install of these packages in the exact same
    version on a different system. (Right now you can get this only by using the
    choco GUI-tool)

    -----------------------------------------------------------------------------

    The .xml-file has the following structure:

    <?xml version="1.0" encoding="utf-8"?>
        <packages>
          <package id="apackage" />
          <package id="anotherPackage" version="1.1" />
          <package id="chocolateytestpackage" version="0.1" source="somelocation" />
          <package id="alloptions" version="0.1.1"
                   source="https://somewhere/api/v2/" installArguments=""
                   packageParameters="" forceX86="false" allowMultipleVersions="false"
                   ignoreDependencies="false"
                   />
        </packages>

    -----------------------------------------------------------------------------
    See https://docs.chocolatey.org/en-us/choco/commands/install for more details

.PARAMETER OutFile
    Specifies a path to the output .xml-file
.PARAMETER Print
    Boolean switch, specifying to print also, when -outFile is given
.PARAMETER DatePrefix
    Boolean switch, specifying to prefix filename by current date in ISO-format
.PARAMETER HostPrefix
    Boolean switch, specifying to prefix filename by current hostname
.EXAMPLE
    .\Get-Choco-Packages.ps1
    Prints XML-content on stdout
.EXAMPLE
    C:\PS> .\Get-Choco-Packages.ps1 -OutFile packages.config -DatePrefix
    Writes to file named packages.config in current directory and prefixes date
.EXAMPLE
    C:\PS> .\Get-Choco-Packages.ps1 -OutFile packages.config -Print
    Writes to file named packages.config in current directory and prints XML-content to stdout also.
.NOTES
    Author: 6ru and de_ramon
    Date:   May 31, 2021

#>

 param (
    [Parameter(Mandatory=$false)][string] $OutFile,
    [switch]$Print = $false,
    [switch]$DatePrefix = $false,
    [switch]$HostPrefix = $false
 )

# Retrieve installed packages name and version separated by pipe-character
$chocoOutput = $(choco list --local --limit-output)

    $stringWriter = New-Object System.IO.StringWriter;
    $XmlWriter = New-Object System.Xml.XmlTextWriter($stringWriter)


$XmlWriter.Formatting = "indented";

# Write the XML Decleration and set the XSL
$xmlWriter.WriteStartDocument()
$xmlWriter.WriteStartElement("packages")


# Loop over each line an construct xml-element
ForEach ($line in $($chocoOutput -split "`r`n")){
    $elements = $line.split("|")

    $xmlWriter.WriteStartElement("package");
    $xmlWriter.WriteAttributeString("id", $elements[0]);
    $xmlWriter.WriteAttributeString("version", $elements[1]);
    $xmlWriter.WriteEndElement();

}
$xmlWriter.WriteEndElement()

$xmlWriter.Flush()
$xmlWriter.Close()


if($OutFile){

    if ($HostPrefix){
        $outFile = $("$env:computername") + "_" + $OutFile
    }
    if ($DatePrefix){
        $outFile = $(Get-Date -UFormat "+%Y-%m-%dT%H.%M.%S") + "_" + $OutFile
    }
    Write-Output $stringWriter.ToString() | Out-File -FilePath $OutFile
}

if (! $OutFile -or $Print ){
    $stringWriter.Flush();
    Write-Output $stringWriter.ToString()
}

