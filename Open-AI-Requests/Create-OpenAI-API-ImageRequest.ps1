$openai_image_uri = "https://api.openai.com/v1/images/generations"

if ($null -eq $openai_api_key) {
    $openai_key_cred = Get-Credential("APIKey")
}
$openai_api_key = ($openai_key_cred).Password | ConvertFrom-securestring -asplaintext

$prompt_oai = @"
try combining the ubiquitious powershell >_ logo and the OpenAI logo. Should include a terminal motif and an image in the terminal 
"@

$openai_auth_headers = @{
    "Authorization" =  "Bearer $openai_api_key"
    }

$openai_prompt_params = @{
    "model" = "dall-e-3"
    "prompt" = $prompt_oai
    "quality" = "hd"
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
$image_request_json_content_object = $image_request.Content | ConvertFrom-Json

$destination = ("./OpenAI-Generations/" + "image-"+(Get-Date -Format 'yyyy-MM-dd')+ "-" + (Get-Random -count 1 -Maximum 1000) + ".png")

Start-BitsTransfer -destination $destination -Source $image_request_json_content_object.data.url
write-output "============"
write-output $image_request.Content
