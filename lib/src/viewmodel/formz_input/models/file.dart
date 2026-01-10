enum FileType {pdf, image, doc, none}
enum FileSource {network, local, none}

class File {

  final FileType fileType;
  final FileSource fileSource;
  final String path;

  const File({required this.fileType, required this.fileSource, required this.path});

}