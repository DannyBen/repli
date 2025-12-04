# repli - Replicate Workspace Tool

Command line utility that is designed to allow easy access to the Replicate API
using a YAML configuration file.

## Concept

1. You create a YAML file (can be created from a template by running
   `repli new`).
2. You edit the YAML file with the API options.
3. You run `repli get` to call the API and automatically save its output.

File uploads are handled automatically.

## YAML Configuration

repli expects a YAML configuration (named `repli.yaml` by default) to exist in 
the current directory, and include two options: `model` and `input`.

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
will be saved in `files.ini` in the working directory, in order to avoid
unnecessary subsequent uploads.

There is also a `repli upload` command available, in case you wish to handle
the uploading manually.

## YAMl Templates

Storing configuration templates in a directory (defined by
`REPLI_MODELS_DIR`) allows you to summon these templates to the working
directory by running `repli new`.

