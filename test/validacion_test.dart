import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/validacion.dart';

void main() {
  group('validarTitulo', () {
    test('rechaza un título vacío', () {
      expect(validarTitulo(''), isNotNull);
    });

    test('rechaza un título de solo espacios', () {
      expect(validarTitulo('     '), isNotNull);
    });

    test('rechaza tabulaciones y saltos de línea', () {
      expect(validarTitulo('\t\n  '), isNotNull);
    });

    test('acepta un título normal', () {
      expect(validarTitulo('Comprar pan'), isNull);
    });
  });

  group('normalizarTitulo', () {
    test('recorta los espacios de los extremos', () {
      expect(normalizarTitulo('  Comprar pan  '), 'Comprar pan');
    });

    test('conserva los espacios internos', () {
      expect(normalizarTitulo('Comprar  pan'), 'Comprar  pan');
    });
  });

  group('exigirTituloValido', () {
    test('lanza TituloInvalidoException con un título vacío', () {
      expect(
        () => exigirTituloValido('   '),
        throwsA(isA<TituloInvalidoException>()),
      );
    });

    test('no lanza nada con un título válido', () {
      expect(() => exigirTituloValido('Comprar pan'), returnsNormally);
    });
  });
}