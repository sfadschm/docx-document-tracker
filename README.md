# MS Office Document Tracker
This is a sample `git` project to demonstate how to track progress on a thesis/report or whatever else document written in the Microsoft Office Word `.docx` file format.  
It is primarily setup to work on Microsoft Windows operating systems and functionality on all other platforms has not been tested.

## Requirements
Tracking your Microsoft Office-based thesis with `git` works best with [Github Desktop](https://desktop.github.com).
To generate meaningful and human-readable diffs, the following packages should be installed on your dektop:

* [Git for Windows](https://git-scm.com/download/win)  
  The Windows distribution of `git`. Make sure to enable Linux bash commands during the installation process.

* [Github Desktop](https://desktop.github.com) (optional)  
  This is a really handy git GUI client for Windows which eases repository management, commits and presents really nice diff views.  
  Its use is highly recommended.

* [Pandoc](https://pandoc.org/)  
  This will generate nicely formatted text-diffs in `markdown` syntax from `.docx`. Pandoc is a powerful conversion library which supports a large variety of office features.

* [PDFMiner](https://pypi.org/project/pdfminer/)  
  Generates very basic text-diffs from `.pdf` files. Note that text in vector images (e.g., `.emf`) will in some cases also be extracted and can mess up the diff view.

Please make sure that these commands are included in `PATH` and can be executed from the command line.

## Installation
Clone this repository and add the following settings in `.git\config`:

    [diff "pandoc"]
      textconv = pandoc --to=markdown 
      prompt = false
      binary = true
    [diff "pdf"]
      textconv = pdf2txt.py
      binary = true

This  configuration will enable the generation of user-readable diffs inside of Github Desktop.

You can of course also add this configuration settings to your global `.gitconfig` to make it available for all your projects.

## Usage

### Recommended writing methods
While writing your document in MS Word, stick to some basic rules to avoid problems with document loading times, crashes and other stuff that people keep complaining about. Here are some of those as an entry point:

* Insert your images as links instead of embedding them in the document.  
  Managing your images in the `images` folder has several advantages:
  - `.docx` files are just archives. If you embed an image, it is stored inside the `media` folder of the archive and your documents' file size increases. Large `docx` files are much more prone to crashes than small ones.
  - Linked images are automatically updated in the `docx` file whenever you replace them with a new version in the `images` folder. No need to manually replace (and most often resize) them inside the document.
  - The `images` folder is tracked by `git`. If you replace an image and want to revert the changes later, just click through your history and watch the beautiful image diffs of Github Desktop.  

  If you want to follow this guide, you can add a linked image to your document via  
  ```Insert > Quick Parts > Fields > IncludePicture```  
  Enter `images/YourImageName.extension` into the `File Name` and you're ready to go. 

### Publishing your document
This package comes with two pre-configured automatic release methods:

* Using the `post-commit` hook  
  Inside the `.git/hooks`folde you can find a `post-commit` hook. This is enabled by default and is the primary way to automate releases on a local machine.
  
  The hook is triggered by commits containing a commit message composed like `Prepare v7.4`, where `Prepare v` is the keyword the hook checks against and the following version number will be used for the release. If a valid commit is detected and it contains changes to one or more `.docx` files, the hook copies these file to the `releases` folder and submits a `Release _file name_ v7.4` commit to the repository.
* Using the `github workflow`  
  Inside the `.github/workflows` folder you can find a Github action file `release.yml.dist`. This action triggers a release action similar to the one executed by the git hook, but only when changes to a `.docx` file are pushed to the Github repository and the commit message contains `Prepare v` (see the description of the hook).

  To enable the action, simple remove the `.dist` extension from the workflow file.
* Manual releases  
  Of course, you can also manually release a new version of a document by  
  - commiting all changes,
  - copying the document to be released to the `release folder`,
  - renaming the new file with `vX.x`,
  - comitting the new release to the repository.

## Contributing
Any improvements, suggestions and questions about this project are welcome at any time.  

Feel free to open an issue for discussion if you think you found a mistake, have suggestions for improvement or extension or whatever else is on your mind.

## Licence
This project does not have a licence, do whatever you want to do.

For more information, refer to the `LICENCE` file or visit [The Unlicense](http://unlicense.org).