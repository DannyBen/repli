# repli - Replicate Workspace Tool

Command line utility that is designed to provide easy access to the Replicate
API using YAML configuration files.

## Concept

1. You create a YAML file based on Replicate examples.
2. You edit the YAML file with the API options.
3. You run `repli get` to call the API and automatically save its output.

File uploads are handled automatically.

## Installation

Soon

## Quick Start

Download your first template. This command uses the Replicate API to obtain the
example for a given model, and creates a YAML template in the templates
directory.

```bash
repli templates new black-forest-labs/flux-schnell
```

Now, in an empty directory, create repli.yml from this template:

```bash
repli new flux-schnell
```

Edit the generated `repli.yml` file, and then call the API using this command:

```bash
repli get
```

You should see a JSON file and as well as the image file saved in your working
directory.


## YAML Configuration

repli expects a YAML configuration (named `repli.yaml` by default) to exist in 
the working directory, and include two options: `model` and `input`.

The `input` may contain any option supported by the replicate model.

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

