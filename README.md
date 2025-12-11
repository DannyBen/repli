<div align='center'>
<img src='support/header.jpg'>

# repli - Replicate AI Workspace Tool

</div>

---

**repli** is a command-line tool that turns Replicate API calls into a clean,
reproducible, YAML-driven workflow.  
Generate templates, edit your configuration, run a single command, and let
repli handle file uploads, API calls, and output saving.

With repli, you can:

- Generate starter templates directly from Replicate models  
- Edit simple YAML instead of crafting JSON payloads  
- Automatically upload local files  
- Save outputs predictably in your working directory  
- Keep your AI workflows organized and version-controllable  

repli was developed using the [Bashly Command Line Framework][bashly].

---

## Concept

repli simplifies working with Replicate into three steps:

1. Generate a YAML template for any Replicate model (once per model):  
   ```console
   repli template new google/nano-banana
   ```
2. Copy the template to the working directory:  
   ```console
   repli new nano-banana
   ```
3. Edit the local repli.yaml to configure the model's inputs:  
   ```console
   repli edit
   ```
4. Run the model:  
   ```console
   repli go
   ```

Local file references are handled automatically, and all output files are saved
directly to your working directory.

Process overview:

```
template → edit YAML → repli go → output files
```

## Installation

repli comes as a single standalone bash script which you can download from this
repository, or from the [latest releases page][release].

You can also install repli using one of these methods:

**Manual download**

```console
# download the latest release and place it in /usr/local/bin
wget https://github.com/DannyBen/repli/releases/latest/download/repli
sudo install -m 0755 repli /usr/local/bin/
```

**Using the setup script**

*This [setup script][setup] is doing the same thing.*

```console
curl -Ls get.dannyb.co/repli/setup | bash
```


## Quick Start

### 1. Generate a model template

```
repli templates new black-forest-labs/flux-schnell
```

### 2. Use the template to create `repli.yaml` in your working directory

```
repli new flux-schnell
```

### 3. Edit the YAML file  

```
repli edit
```

### 4. Run the model

```
repli go
```

### 5. Check your working directory  

You'll find:

- A JSON response file  
- Any resulting image or output files  
- A `files.ini` file tracking uploaded assets  

## YAML Configuration

repli expects a configuration file named `repli.yaml` in the current directory.  
It must include an `input` dictionary:

- `input`: a mapping of any valid model options  

and either `model` (for official models) or `version` (for unofficial models)
option:

- `model`: the Replicate model name  
- `version`: the Replicate model version in the form of `author/model:version`

Example:

```yaml
# repli.yaml - official model
model: google/nano-banana
input:
  prompt: tuxedo cat standing on a black and white printer
  aspect_ratio: "1:1"
  output_format: png
  image_input:
    - value: <sample.png>
```

```yaml
# repli.yaml - unofficial model
version: jingyunliang/swinir:660d...021a
input:
  image: <source.jpg>
  task_type: Real-World Image Super-Resolution-Large
```

See more examples in the [examples folder][examples].

## File Uploads

Any YAML value written in the form:

```
<sample.png>
```

is treated as a local file path that is expected to be uploaded to Replicate.

repli will automatically:

1. Upload the file to Replicate  
2. Store the resulting URL in `files.ini`  
3. Reuse that URL on future runs to avoid unnecessary uploads  

## File Embeds

Any YAML value written in the form:

```
~file.txt
```

will be replaced with the contents of that file before repli continues
processing the configuration.

This allows you to keep longer text - like prompts - outside of your
`repli.yaml` file while still embedding their contents directly
into the final request.

---

## Contributing / Support

If you have questions, suggestions, or run into an issue, feel free to open an
[issue][issues] on GitHub:


[bashly]: https://bashly.dannyb.co/
[issues]: https://github.com/DannyBen/repli/issues
[examples]: https://github.com/DannyBen/repli/tree/master/examples
[release]: https://github.com/DannyBen/repli/releases/latest
[setup]: https://github.com/DannyBen/repli/tree/master/setup

