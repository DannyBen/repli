# repli - Replicate Workspace Tool

Command line utility that is designed to provide easy access to the Replicate
API using YAML configuration files.

## Concept

1. You create a YAML file based on Replicate examples
   (`repli templates new google/nano-banana`)
2. You edit the YAML file to configure API options.
3. You run repli to call the API and save the output (`repli get`).

File uploads are handled automatically. Local files specified in angled
brackets (e.g., `<sample.png>`) are uploaded to Replicate before the API call.

## Installation

Installation instructions will be provided here.

## Quick Start

Get your first template. This command fetches an example for a given model from
the Replicate API and creates a YAML template in the templates directory.

```bash
repli templates new black-forest-labs/flux-schnell
```

Now, in an empty directory, create `repli.yml` from this template by running:

```bash
repli new flux-schnell
```

Edit the generated `repli.yml` file, and then call the API by running:

```bash
repli get
```

You should see a JSON file and as well as the image file saved in your working
directory.


## YAML Configuration

repli expects a YAML configuration (named `repli.yml` by default) to exist in 
the working directory, and include two options: `model` and `input`.

The `input` may contain any option supported by the model on Replicate.

For example:

```yaml
# repli.yaml
model: google/nano-banana
input:
  prompt: tuxedo cat standing on a black and white printer
  aspect_ratio: "1:1"
  output_format: png
  image_input:
  - value: <sample.png>
```

### File Uploads

Any value inside angled brackets, like `<sample.png>` above, means that this
is a local file that is expected to be uploaded to Replicate prior to calling
the API. In this case, the local file will be uploaded, and the resulting URL
saved in `files.ini` in the working directory, in order to avoid unnecessary
subsequent uploads.

