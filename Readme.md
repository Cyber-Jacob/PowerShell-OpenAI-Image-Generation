## OpenAI Image Generation 

This is a powershell script that can be used to generate OpenAI images in an ad-hoc way.
This script and any subsequent modules are based off the OpenAI documentation available at `https://platform.openai.com/docs/guides/images`

This script is a candidate to turn into a module. This will likely take the form of a Powershell-appropriate name such as "Invoke-OpenAI-Image-Request" or some other cmdlet type name.

---

## B64 output versus querying OAI temporarily hosted Images
With the release of OpenAI's "gpt-image-x" models, there is no longer an option to invoke a web request to a hosted blob with the image. Instead, the API returns a b64 blob directly to the POST request. On 2026-01-22 we updated this API script to convert directly from Base64 to .png files in-script instead of the old method of pulling the Image URI and performing another subsequent Invoke-WebRequest command.

## IWR Vs. Start-BITSTransfer
Invoke-WebRequest has replaced Start-BITSTransfer for cross-platform compatibility.

