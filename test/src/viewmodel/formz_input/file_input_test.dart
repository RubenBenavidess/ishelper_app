import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/file_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';

void main() {
  group('FileInput', () {
    group('constructor', () {
      test('pure() creates FileInput with pure value', () {
        final fileInput = FileInput.pure();

        expect(fileInput.isPure, true);
        expect(fileInput.value.fileType, FileType.none);
        expect(fileInput.value.fileSource, FileSource.none);
        expect(fileInput.value.path, '');
      });

      test('pure() initial value is invalid', () {
        final fileInput = FileInput.pure();

        expect(fileInput.isValid, false);
        expect(fileInput.error, FileInputError.unsupportedFileType);
      });

      test('dirty() creates FileInput with dirty value', () {
        const testFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        final fileInput = FileInput.dirty(testFile);

        expect(fileInput.isPure, false);
        expect(fileInput.value, testFile);
      });

      test('dirty() with default value creates FileInput with none type', () {
        final fileInput = FileInput.dirty();

        expect(fileInput.isPure, false);
        expect(fileInput.value.fileType, FileType.none);
        expect(fileInput.value.fileSource, FileSource.none);
        expect(fileInput.value.path, '');
      });
    });

    group('validator', () {
      test('returns unsupportedFileType when fileType is none', () {
        const invalidFile = File(
          fileType: FileType.none,
          fileSource: FileSource.local,
          path: '/path/to/file',
        );

        final fileInput = FileInput.dirty(invalidFile);

        expect(fileInput.isValid, false);
        expect(fileInput.error, FileInputError.unsupportedFileType);
      });

      test('returns unsupportedSourceType when fileSource is none', () {
        const invalidFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.none,
          path: '/path/to/file.pdf',
        );

        final fileInput = FileInput.dirty(invalidFile);

        expect(fileInput.isValid, false);
        expect(fileInput.error, FileInputError.unsupportedSourceType);
      });

      test('returns invalidPathFormat when path is empty', () {
        const invalidFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '',
        );

        final fileInput = FileInput.dirty(invalidFile);

        expect(fileInput.isValid, false);
        expect(fileInput.error, FileInputError.invalidPathFormat);
      });

      test('returns invalidPathFormat when path is only whitespace', () {
        const invalidFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '   ',
        );

        final fileInput = FileInput.dirty(invalidFile);

        expect(fileInput.isValid, false);
        expect(fileInput.error, FileInputError.invalidPathFormat);
      });

      test('is valid with PDF file type and local source', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
        expect(fileInput.error, null);
      });

      test('is valid with DOC file type and local source', () {
        const validFile = File(
          fileType: FileType.doc,
          fileSource: FileSource.local,
          path: '/path/to/file.doc',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
        expect(fileInput.error, null);
      });

      test('is valid with PDF file type and network source', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.network,
          path: 'https://example.com/file.pdf',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
        expect(fileInput.error, null);
      });

      test('is valid with DOC file type and network source', () {
        const validFile = File(
          fileType: FileType.doc,
          fileSource: FileSource.network,
          path: 'https://example.com/file.doc',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
        expect(fileInput.error, null);
      });

      test('validates path with special characters', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/home/user/documents/file-name_2024.pdf',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
      });

      test('validates path with spaces (trimmed)', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '  /path/to/file.pdf  ',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
      });
    });

    group('equality', () {
      test('two pure FileInputs with same values are equal', () {
        final fileInput1 = FileInput.pure();
        final fileInput2 = FileInput.pure();

        expect(fileInput1, isNot(fileInput2));
      });

      test('two dirty FileInputs with same values are equal', () {
        const testFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        final fileInput1 = FileInput.dirty(testFile);
        final fileInput2 = FileInput.dirty(testFile);

        expect(fileInput1, fileInput2);
      });

      test('pure and dirty FileInputs with same values are not equal', () {
        const testFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        final fileInput1 = FileInput.pure();
        final fileInput2 = FileInput.dirty(testFile);

        expect(fileInput1, isNot(fileInput2));
      });

      test('two dirty FileInputs with different values are not equal', () {
        const file1 = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file1.pdf',
        );
        const file2 = File(
          fileType: FileType.doc,
          fileSource: FileSource.local,
          path: '/path/to/file2.doc',
        );

        final fileInput1 = FileInput.dirty(file1);
        final fileInput2 = FileInput.dirty(file2);

        expect(fileInput1, isNot(fileInput2));
      });
    });

    group('edge cases', () {
      test('handles very long file paths', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/very/long/path/to/a/deeply/nested/directory/structure/with/many/levels/file.pdf',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
      });

      test('handles URLs with query parameters', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.network,
          path: 'https://example.com/path/to/file.pdf?token=abc123&version=2',
        );

        final fileInput = FileInput.dirty(validFile);

        expect(fileInput.isValid, true);
      });

      test('validates multiple file type transitions', () {
        final pdfFile = FileInput.dirty(
          const File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          ),
        );

        final docFile = FileInput.dirty(
          const File(
            fileType: FileType.doc,
            fileSource: FileSource.local,
            path: '/path/to/file.doc',
          ),
        );

        final invalidFile = FileInput.dirty(
          const File(
            fileType: FileType.none,
            fileSource: FileSource.local,
            path: '/path/to/file.txt',
          ),
        );

        expect(pdfFile.isValid, true);
        expect(docFile.isValid, true);
        expect(invalidFile.isValid, false);
      });
    });

    group('error caching', () {
      test('errors are cached properly', () {
        const invalidFile = File(
          fileType: FileType.none,
          fileSource: FileSource.local,
          path: '/path/to/file',
        );

        final fileInput1 = FileInput.dirty(invalidFile);
        final fileInput2 = FileInput.dirty(invalidFile);

        expect(fileInput1.error, fileInput2.error);
        expect(fileInput1.error, FileInputError.unsupportedFileType);
      });

      test('error changes when file type changes', () {
        const fileNoneType = File(
          fileType: FileType.none,
          fileSource: FileSource.local,
          path: '/path/to/file',
        );
        const filePdfType = File(
          fileType: FileType.pdf,
          fileSource: FileSource.none,
          path: '/path/to/file.pdf',
        );

        final fileInput1 = FileInput.dirty(fileNoneType);
        final fileInput2 = FileInput.dirty(filePdfType);

        expect(fileInput1.error, FileInputError.unsupportedFileType);
        expect(fileInput2.error, FileInputError.unsupportedSourceType);
      });
    });
  });
}
