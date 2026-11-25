String normalizarTitulo(String titulo) => titulo.trim();

String? validarTitulo(String? titulo) {
  if (titulo == null || normalizarTitulo(titulo).isEmpty) {
    return 'El título no puede estar vacío';
  }
  return null;
}

//Esta clase me ayudó a implementarla la IA
//Mencionó un problema respecto a la validación del título
//Y sugirió usar esta excepcion para evitar titulos vacios
class TituloInvalidoException implements Exception {
  final String mensaje;
  const TituloInvalidoException(this.mensaje);

  @override
  String toString() => mensaje;
}
void exigirTituloValido(String titulo) {
  final error = validarTitulo(titulo);
  if (error != null) throw TituloInvalidoException(error);
}

