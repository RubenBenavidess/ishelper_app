import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:ishelper_app/src/services/file_input_service.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/file_input.dart';
import 'package:ishelper_app/src/viewmodel/formz_input/models/file.dart';
import 'package:ishelper_app/src/viewmodel/states/file_state.dart';
import 'package:mocktail/mocktail.dart';

class MockFileInputService extends Mock implements FileInputService {}

void main() {
  group('FileCubit', () {
    late MockFileInputService mockFileInputService;
    late FileCubit fileCubit;

    setUp(() {
      mockFileInputService = MockFileInputService();
      fileCubit = FileCubit(fileInputService: mockFileInputService);
    });

    tearDown(() {
      fileCubit.close();
    });

    group('constructor', () {
      test('initial state is FileState.initial(), but not PURE.', () {
        expect(fileCubit.state.status, FormzSubmissionStatus.initial);
        expect(fileCubit.state.isValid, false);
      });

      test('fileInputService is properly injected', () {
        expect(fileCubit.fileInputService, mockFileInputService);
      });
    });

    group('fileChanged', () {
      blocTest<FileCubit, FileState>(
        'emits new state with dirty FileInput when valid file is provided',
        build: () => fileCubit,
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          );
          cubit.fileChanged(validFile);
        },
        expect: () => [
          predicate<FileState>((state) {
            return !state.fileInput.isPure &&
                state.fileInput.value.fileType == FileType.pdf &&
                state.fileInput.value.fileSource == FileSource.local &&
                state.fileInput.isValid == true &&
                state.isValid == true &&
                state.status == FormzSubmissionStatus.initial;
          })
        ],
      );

      blocTest<FileCubit, FileState>(
        'emits new state with invalid FileInput when invalid file is provided',
        build: () => fileCubit,
        act: (cubit) {
          const invalidFile = File(
            fileType: FileType.none,
            fileSource: FileSource.local,
            path: '/path/to/file',
          );
          cubit.fileChanged(invalidFile);
        },
        expect: () => [
          predicate<FileState>((state) {
            return !state.fileInput.isPure &&
                state.fileInput.isValid == false &&
                state.isValid == false &&
                state.fileInput.error == FileInputError.unsupportedFileType;
          })
        ],
      );

      blocTest<FileCubit, FileState>(
        'emits correct state for PDF file with local source',
        build: () => fileCubit,
        act: (cubit) {
          const pdfFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/documents/report.pdf',
          );
          cubit.fileChanged(pdfFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.isValid, 'is valid', true)
              .having((state) => state.isValid, 'state is valid', true),
        ],
      );

      blocTest<FileCubit, FileState>(
        'emits correct state for DOC file with network source',
        build: () => fileCubit,
        act: (cubit) {
          const docFile = File(
            fileType: FileType.doc,
            fileSource: FileSource.network,
            path: 'https://example.com/document.doc',
          );
          cubit.fileChanged(docFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.isValid, 'is valid', true)
              .having((state) => state.isValid, 'state is valid', true),
        ],
      );

      blocTest<FileCubit, FileState>(
        'emits new state with empty path error',
        build: () => fileCubit,
        act: (cubit) {
          const invalidFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '',
          );
          cubit.fileChanged(invalidFile);
        },
        expect: () => [
          isA<FileState>()
              .having(
                (state) => state.fileInput.error,
                'has path format error',
                FileInputError.invalidPathFormat,
              )
              .having((state) => state.isValid, 'state is invalid', false),
        ],
      );

      blocTest<FileCubit, FileState>(
        'emits new state with whitespace-only path error',
        build: () => fileCubit,
        act: (cubit) {
          const invalidFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '   ',
          );
          cubit.fileChanged(invalidFile);
        },
        expect: () => [
          isA<FileState>()
              .having(
                (state) => state.fileInput.error,
                'has path format error',
                FileInputError.invalidPathFormat,
              )
              .having((state) => state.isValid, 'state is invalid', false),
        ],
      );

      blocTest<FileCubit, FileState>(
        'updates state when file is changed multiple times',
        build: () => fileCubit,
        act: (cubit) {
          const file1 = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file1.pdf',
          );
          const file2 = File(
            fileType: FileType.doc,
            fileSource: FileSource.network,
            path: 'https://example.com/file2.doc',
          );

          cubit.fileChanged(file1);
          cubit.fileChanged(file2);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.isValid, 'first file valid', true),
          isA<FileState>()
              .having((state) => state.fileInput.value.fileType, 'fileType changed',
                  FileType.doc),
        ],
      );

      blocTest<FileCubit, FileState>(
        'maintains FormzSubmissionStatus as initial after fileChanged',
        build: () => fileCubit,
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          );
          cubit.fileChanged(validFile);
        },
        expect: () => [
          isA<FileState>().having(
            (state) => state.status,
            'status remains initial',
            FormzSubmissionStatus.initial,
          ),
        ],
      );

      blocTest<FileCubit, FileState>(
        'handles file with special characters in path',
        build: () => fileCubit,
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/home/user/documents/file-name_2024 (1).pdf',
          );
          cubit.fileChanged(validFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.isValid, 'is valid', true),
        ],
      );

      blocTest<FileCubit, FileState>(
        'handles long file paths correctly',
        build: () => fileCubit,
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path:
                '/very/long/path/to/a/deeply/nested/directory/structure/with/many/levels/important_document.pdf',
          );
          cubit.fileChanged(validFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.isValid, 'is valid', true),
        ],
      );
    });

    group('_validate method (private)', () {
      test('validates null fileInput as invalid', () {
        const invalidFile = File(
          fileType: FileType.none,
          fileSource: FileSource.local,
          path: '/path/to/file',
        );
        fileCubit.fileChanged(invalidFile);

        expect(fileCubit.state.isValid, false);
      });

      test('validates valid fileInput as true', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );
        fileCubit.fileChanged(validFile);

        expect(fileCubit.state.isValid, true);
      });
    });

    group('state transitions', () {
      blocTest<FileCubit, FileState>(
        'transitions from pure to dirty state',
        build: () => fileCubit,
        seed: () => FileState.initial(),
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          );
          cubit.fileChanged(validFile);
        },
        expect: () => [
          isA<FileState>()
              .having(
                (state) => state.fileInput.isPure,
                'changes from pure to dirty',
                false,
              )
              .having((state) => state.fileInput.isValid, 'becomes valid', true),
        ],
      );

      blocTest<FileCubit, FileState>(
        'transitions between different file types',
        build: () => fileCubit,
        act: (cubit) {
          const pdfFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          );
          const docFile = File(
            fileType: FileType.doc,
            fileSource: FileSource.local,
            path: '/path/to/file.doc',
          );

          cubit.fileChanged(pdfFile);
          cubit.fileChanged(docFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.value.fileType, 'is PDF',
                  FileType.pdf),
          isA<FileState>()
              .having((state) => state.fileInput.value.fileType, 'is DOC',
                  FileType.doc),
        ],
      );

      blocTest<FileCubit, FileState>(
        'transitions between valid and invalid states',
        build: () => fileCubit,
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          );
          const invalidFile = File(
            fileType: FileType.none,
            fileSource: FileSource.local,
            path: '/path/to/file',
          );

          cubit.fileChanged(validFile);
          cubit.fileChanged(invalidFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.isValid, 'first state is valid', true),
          isA<FileState>()
              .having((state) => state.isValid, 'second state is invalid', false),
        ],
      );
    });

    group('uploadFile method', () {
      test('uploadFile exists but is not fully implemented', () {
        const testFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        expect(() => fileCubit.uploadFile(testFile), returnsNormally);
      });

      test('uploadFile does not change state', () async {
        const testFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        final initialState = fileCubit.state;
        fileCubit.uploadFile(testFile);

        expect(fileCubit.state, initialState);
      });
    });

    group('edge cases and error scenarios', () {
      blocTest<FileCubit, FileState>(
        'handles rapid successive file changes',
        build: () => fileCubit,
        act: (cubit) {
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
          const file3 = File(
            fileType: FileType.pdf,
            fileSource: FileSource.network,
            path: 'https://example.com/file3.pdf',
          );

          cubit.fileChanged(file1);
          cubit.fileChanged(file2);
          cubit.fileChanged(file3);
        },
        expect: () => [
          isA<FileState>(),
          isA<FileState>(),
          isA<FileState>(),
        ],
      );

      blocTest<FileCubit, FileState>(
        'handles URL with query parameters and fragments',
        build: () => fileCubit,
        act: (cubit) {
          const urlFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.network,
            path:
                'https://example.com/files/document.pdf?token=abc123&version=2#section',
          );
          cubit.fileChanged(urlFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.fileInput.isValid, 'is valid', true),
        ],
      );

      blocTest<FileCubit, FileState>(
        'handles consecutive valid and invalid file changes',
        build: () => fileCubit,
        act: (cubit) {
          const validFile = File(
            fileType: FileType.pdf,
            fileSource: FileSource.local,
            path: '/path/to/file.pdf',
          );
          const invalidFile = File(
            fileType: FileType.none,
            fileSource: FileSource.none,
            path: '',
          );
          const anotherValidFile = File(
            fileType: FileType.doc,
            fileSource: FileSource.network,
            path: 'https://example.com/doc.doc',
          );

          cubit.fileChanged(validFile);
          cubit.fileChanged(invalidFile);
          cubit.fileChanged(anotherValidFile);
        },
        expect: () => [
          isA<FileState>()
              .having((state) => state.isValid, 'first is valid', true),
          isA<FileState>()
              .having((state) => state.isValid, 'second is invalid', false),
          isA<FileState>()
              .having((state) => state.isValid, 'third is valid', true),
        ],
      );
    });

    group('state consistency', () {
      test('fileInput validation matches state.isValid', () {
        const validFile = File(
          fileType: FileType.pdf,
          fileSource: FileSource.local,
          path: '/path/to/file.pdf',
        );

        fileCubit.fileChanged(validFile);

        expect(
          fileCubit.state.fileInput.isValid,
          equals(fileCubit.state.isValid),
        );
      });

      test('fileInput validation matches state.isValid with invalid file', () {
        const invalidFile = File(
          fileType: FileType.none,
          fileSource: FileSource.local,
          path: '',
        );

        fileCubit.fileChanged(invalidFile);

        expect(
          fileCubit.state.fileInput.isValid,
          equals(fileCubit.state.isValid),
        );
      });

      test('state correctly reflects all file properties', () {
        const testFile = File(
          fileType: FileType.doc,
          fileSource: FileSource.network,
          path: 'https://example.com/document.doc',
        );

        fileCubit.fileChanged(testFile);

        expect(fileCubit.state.fileInput.value.fileType, FileType.doc);
        expect(fileCubit.state.fileInput.value.fileSource, FileSource.network);
        expect(fileCubit.state.fileInput.value.path, 'https://example.com/document.doc');
      });
    });
  });
}
