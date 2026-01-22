$openai_image_uri = "https://api.openai.com/v1/images/generations"

if ($null -eq $openai_api_key) {
    $openai_key_cred = Get-Credential("APIKey")
}
$openai_api_key = ($openai_key_cred).Password | ConvertFrom-securestring -asplaintext

$defaultprompt = @"
**Cyber Security:**
   - "A mission patch for PowerShell with elements like a shield, P, dollar sign, lock, and binary code, symbolizing security and
protection.
"@

$user_prompt = Read-Host -Prompt "Please enter an image prompt:"

if ([string]::IsNullOrEmpty($user_prompt)) {
    $prompt_oai=$defaultprompt
}

Write-Host "Your prompt is as follows:`n$prompt_oai"

$openai_auth_headers = @{
    "Authorization" =  "Bearer $openai_api_key"
    }

$openai_prompt_params = @{
    "model" = "gpt-image-1.5"
    "prompt" = $prompt_oai
    "quality" = "high"
    "n" = 1
    "size" = "1024x1024"
}

$openai_prompt_params_json = $openai_prompt_params | ConvertTo-Json


$image_creation_request_splat_parameters = @{
    "URI" = $openai_image_uri
    "Headers" = $openai_auth_headers
    "ContentType" = "application/json"
    "Body" = $openai_prompt_params_json
    "Method" = "POST"
}

$image_request = Invoke-WebRequest @image_creation_request_splat_parameters
write-output $image_request
$image_request | ForEach-Object {write-output $_}

$image_b64_object=($image_request.Content | convertfrom-json).data.b64_json

$destination = ("./OpenAI-Generations/" + "image-"+(Get-Date -Format 'yyyy-MM-dd_hh-mm-ss')+ "-" + (Get-Random -count 1 -Maximum 1000) + ".png")

$b64bytes = [Convert]::FromBase64String($image_b64_object)
[System.IO.File]::WriteAllBytes($destination,$b64bytes)

write-output "============"
write-output $image_request.Content
if (Test-Path $destination){
    Write-output "Image saved to $destination.`nPrompt:`n$prompt_oai`n"
}

else {
    Write-output "Image could not be saved to $destination."
}
