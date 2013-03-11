// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas      
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Variables;

interface

const
  // Constantes para insertar fechas a la base de datos
  FECHA_DBMS        = 'mm/dd/yyyy';
  FECHA_HORA_DBMS   = 'mm/dd/yyyy hh:nn:ss.zzz';

  // Constantes para formateo de valores
  FORMATO_FLOTANTE   = '#,###,##0.000';
  FORMATO_DINERO     = '$#,###,##0.000';
  FORMATO_ENTERO     = '#,##0';
  FORMATO_PORCENTAJE = '#,##0.00%';
  FORMATO_HORA       = 'hh:mm:ss';

  // Constantes para campos de estatus en la base de datos
  ACTIVO    = 'A';
  INACTIVO  = 'I';
  CANCELADO = 'C';

  // Constantes para valores afirmativos y negativos
  VALOR_SI        = 'S';
  VALOR_NO        = 'N';

  // Teclas
  TABULADOR     = #8;
  RETROCESO     = #9;
  ENTER         = #13;

implementation

end.
