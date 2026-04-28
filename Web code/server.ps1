# Simple PowerShell HTTP Server
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8000/")
$listener.Start()
Write-Host "Server running at http://localhost:8000/"

while ($true) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $localPath = $request.Url.LocalPath
    
    if ($localPath -eq "/") {
        $localPath = "/index.html"
    }
    
    $filePath = "d:\Ori App\Web code" + $localPath.Replace("/", "\")
    
    if (Test-Path $filePath -PathType Leaf) {
        $buffer = [System.IO.File]::ReadAllBytes($filePath)
        $response.ContentLength64 = $buffer.Length
        
        # Set content type
        $ext = [System.IO.Path]::GetExtension($filePath)
        switch ($ext) {
            ".mp4" { $response.ContentType = "video/mp4" }
            ".html" { $response.ContentType = "text/html" }
            ".css" { $response.ContentType = "text/css" }
            ".js" { $response.ContentType = "application/javascript" }
            ".jpg" { $response.ContentType = "image/jpeg" }
            ".png" { $response.ContentType = "image/png" }
            default { $response.ContentType = "application/octet-stream" }
        }
        
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
    } else {
        $response.StatusCode = 404
    }
    
    $response.OutputStream.Close()
}
