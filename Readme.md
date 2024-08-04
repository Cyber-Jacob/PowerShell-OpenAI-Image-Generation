## OpenAI Image Generation 

This is a powershell script that can be used to generate OpenAI images in an ad-hoc way.
This script and any subsequent modules are based off the OpenAI documentation available at `https://platform.openai.com/docs/guides/images`

This script is a candidate to turn into a module. This will likely take the form of a Powershell-appropriate name such as "Invoke-OpenAI-Image-Request" or some other cmdlet type name.

---

##BITS Transfer

This script makes use of the BITSTransfer tool, as such this requires a user session. When trying to use the BITS Transfer for an account without an active user session, the download will fail. This can be replaced with other commands to perform web requests.