import 'package:flutter/material.dart';

//Clase creada para llevar el control de validacion de una clabe
class ClabeHelper {

  //012180015825699175 MIA BBVA
  //127180016679711614 GALI AZTECA
  //058597000016609950 DIOS BANREGIO

  List<Map<String, String>> _banksTable = [
    {'code': '002', 'shortname': 'BANAMEX', 'name': 'Banco Nacional de México, S.A., Institución de Banca Múltiple, Grupo Financiero Banamex'},
    {'code': '006', 'shortname': 'BANCOMEXT', 'name': 'Banco Nacional de Comercio Exterior, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo'},
    {'code': '009', 'shortname': 'BANOBRAS', 'name': 'Banco Nacional de Obras y Servicios Públicos, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo'},
    {'code': '012', 'shortname': 'BBVA BANCOMER ', 'name': 'BBVA Bancomer, S.A., Institución de Banca Múltiple, Grupo Financiero BBVA Bancomer'},
    {'code': '014', 'shortname': 'SANTANDER', 'name': 'Banco Santander (México), S.A., Institución de Banca Múltiple, Grupo Financiero Santander'},
    {'code': '019', 'shortname': 'BANJERCITO', 'name': 'Banco Nacional del Ejército, Fuerza Aérea y Armada, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo'},
    {'code': '021', 'shortname': 'HSBC', 'name': 'HSBC México, S.A., institución De Banca Múltiple, Grupo Financiero HSBC'},
    {'code': '030', 'shortname': 'BAJIO', 'name': 'Banco del Bajío, S.A., Institución de Banca Múltiple'},
    {'code': '032', 'shortname': 'IXE', 'name': 'IXE Banco, S.A., Institución de Banca Múltiple, IXE Grupo Financiero'},
    {'code': '036', 'shortname': 'INBURSA', 'name': 'Banco Inbursa, S.A., Institución de Banca Múltiple, Grupo Financiero Inbursa'},
    {'code': '037', 'shortname': 'INTERACCIONES', 'name': 'Banco Interacciones, S.A., Institución de Banca Múltiple'},
    {'code': '042', 'shortname': 'MIFEL', 'name': 'Banca Mifel, S.A., Institución de Banca Múltiple, Grupo Financiero Mifel'},
    {'code': '044', 'shortname': 'SCOTIABANK', 'name': 'Scotiabank Inverlat, S.A.'},
    {'code': '058', 'shortname': 'BANREGIO', 'name': 'Banco Regional de Monterrey, S.A., Institución de Banca Múltiple, Banregio Grupo Financiero'},
    {'code': '059', 'shortname': 'INVEX', 'name': 'Banco Invex, S.A., Institución de Banca Múltiple, Invex Grupo Financiero'},
    {'code': '060', 'shortname': 'BANSI', 'name': 'Bansi, S.A., Institución de Banca Múltiple'},
    {'code': '062', 'shortname': 'AFIRME', 'name': 'Banca Afirme, S.A., Institución de Banca Múltiple'},
    {'code': '072', 'shortname': 'BANORTE', 'name': 'Banco Mercantil del Norte, S.A., Institución de Banca Múltiple, Grupo Financiero Banorte'},
    {'code': '102', 'shortname': 'THE ROYAL BANK', 'name': 'The Royal Bank of Scotland México, S.A., Institución de Banca Múltiple'},
    {'code': '103', 'shortname': 'AMERICAN EXPRESS', 'name': 'American Express Bank (México), S.A., Institución de Banca Múltiple'},
    {'code': '106', 'shortname': 'BAMSA', 'name': 'Bank of America México, S.A., Institución de Banca Múltiple, Grupo Financiero Bank of America'},
    {'code': '108', 'shortname': 'TOKYO', 'name': 'Bank of Tokyo-Mitsubishi UFJ (México), S.A.'},
    {'code': '110', 'shortname': 'JP MORGAN', 'name': 'Banco J.P. Morgan, S.A., Institución de Banca Múltiple, J.P. Morgan Grupo Financiero'},
    {'code': '112', 'shortname': 'BMONEX', 'name': 'Banco Monex, S.A., Institución de Banca Múltiple'},
    {'code': '113', 'shortname': 'VE POR MAS', 'name': 'Banco Ve Por Mas, S.A. Institución de Banca Múltiple'},
    {'code': '116', 'shortname': 'ING', 'name': 'ING Bank (México), S.A., Institución de Banca Múltiple, ING Grupo Financiero'},
    {'code': '124', 'shortname': 'DEUTSCHE', 'name': 'Deutsche Bank México, S.A., Institución de Banca Múltiple'},
    {'code': '126', 'shortname': 'CREDIT SUISSE', 'name': 'Banco Credit Suisse (México), S.A. Institución de Banca Múltiple, Grupo Financiero Credit Suisse (México)'},
    {'code': '127', 'shortname': 'AZTECA', 'name': 'Banco Azteca, S.A. Institución de Banca Múltiple.'},
    {'code': '128', 'shortname': 'AUTOFIN', 'name': 'Banco Autofin México, S.A. Institución de Banca Múltiple'},
    {'code': '129', 'shortname': 'BARCLAYS', 'name': 'Barclays Bank México, S.A., Institución de Banca Múltiple, Grupo Financiero Barclays México'},
    {'code': '130', 'shortname': 'COMPARTAMOS', 'name': 'Banco Compartamos, S.A., Institución de Banca Múltiple'},
    {'code': '131', 'shortname': 'BANCO FAMSA', 'name': 'Banco Ahorro Famsa, S.A., Institución de Banca Múltiple'},
    {'code': '132', 'shortname': 'BMULTIVA', 'name': 'Banco Multiva, S.A., Institución de Banca Múltiple, Multivalores Grupo Financiero'},
    {'code': '133', 'shortname': 'ACTINVER', 'name': 'Banco Actinver, S.A. Institución de Banca Múltiple, Grupo Financiero Actinver'},
    {'code': '134', 'shortname': 'WAL-MART', 'name': 'Banco Wal-Mart de México Adelante, S.A., Institución de Banca Múltiple'},
    {'code': '135', 'shortname': 'NAFIN', 'name': 'Nacional Financiera, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo'},
    {'code': '136', 'shortname': 'INTERBANCO', 'name': 'Inter Banco, S.A. Institución de Banca Múltiple'},
    {'code': '137', 'shortname': 'BANCOPPEL', 'name': 'BanCoppel, S.A., Institución de Banca Múltiple'},
    {'code': '138', 'shortname': 'ABC CAPITAL', 'name': 'ABC Capital, S.A., Institución de Banca Múltiple'},
    {'code': '139', 'shortname': 'UBS BANK', 'name': 'UBS Bank México, S.A., Institución de Banca Múltiple, UBS Grupo Financiero'},
    {'code': '140', 'shortname': 'CONSUBANCO', 'name': 'Consubanco, S.A. Institución de Banca Múltiple'},
    {'code': '141', 'shortname': 'VOLKSWAGEN', 'name': 'Volkswagen Bank, S.A., Institución de Banca Múltiple'},
    {'code': '143', 'shortname': 'CIBANCO', 'name': 'CIBanco, S.A.'},
    {'code': '145', 'shortname': 'BBASE', 'name': 'Banco Base, S.A., Institución de Banca Múltiple'},
    {'code': '166', 'shortname': 'BANSEFI', 'name': 'Banco del Ahorro Nacional y Servicios Financieros, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo'},
    {'code': '168', 'shortname': 'HIPOTECARIA FEDERAL', 'name': 'Sociedad Hipotecaria Federal, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo'},
    {'code': '600', 'shortname': 'MONEXCB', 'name': 'Monex Casa de Bolsa, S.A. de C.V. Monex Grupo Financiero'},
    {'code': '601', 'shortname': 'GBM', 'name': 'GBM Grupo Bursátil Mexicano, S.A. de C.V. Casa de Bolsa'},
    {'code': '602', 'shortname': 'MASARI', 'name': 'Masari Casa de Bolsa, S.A. 605 VALUE Value, S.A. de C.V. Casa de B'},
    {'code': '606', 'shortname': 'ESTRUCTURADORES', 'name': 'Estructuradores del Mercado de Valores Casa de Bolsa, S.A. de C.V.'},
    {'code': '607', 'shortname': 'TIBER', 'name': 'Casa de Cambio Tiber, S.A. de C.V.'},
    {'code': '608', 'shortname': 'VECTOR', 'name': 'Vector Casa de Bolsa, S.A. de C.V.'},
    {'code': '610', 'shortname': 'B&B', 'name': 'B y B, Casa de Cambio, S.A. de C.V.'},
    {'code': '614', 'shortname': 'ACCIVAL', 'name': 'Acciones y Valores Banamex, S.A. de C.V., Casa de Bolsa'},
    {'code': '615', 'shortname': 'MERRILL LYNCH', 'name': 'Merrill Lynch México, S.A. de C.V. Casa de Bolsa'},
    {'code': '616', 'shortname': 'FINAMEX', 'name': 'Casa de Bolsa Finamex, S.A. de C.V.'},
    {'code': '617', 'shortname': 'VALMEX', 'name': 'Valores Mexicanos Casa de Bolsa, S.A. de C.V.'},
    {'code': '618', 'shortname': 'UNICA', 'name': 'Unica Casa de Cambio, S.A. de C.V.'},
    {'code': '619', 'shortname': 'MAPFRE', 'name': 'MAPFRE Tepeyac, S.A.'},
    {'code': '620', 'shortname': 'PROFUTURO', 'name': 'Profuturo G.N.P., S.A. de C.V., Afore'},
    {'code': '621', 'shortname': 'CB ACTINVER', 'name': 'Actinver Casa de Bolsa, S.A. de C.V.'},
    {'code': '622', 'shortname': 'OACTIN', 'name': 'OPERADORA ACTINVER, S.A. DE C.V'},
    {'code': '623', 'shortname': 'SKANDIA', 'name': 'Skandia Vida, S.A. de C.V.'},
    {'code': '626', 'shortname': 'CBDEUTSCHE', 'name': 'Deutsche Securities, S.A. de C.V. CASA DE BOLSA'},
    {'code': '627', 'shortname': 'ZURICH', 'name': 'Zurich Compañía de Seguros, S.A.'},
    {'code': '628', 'shortname': 'ZURICHVI', 'name': 'Zurich Vida, Compañía de Seguros, S.A.'},
    {'code': '629', 'shortname': 'SU CASITA', 'name': 'Hipotecaria Su Casita, S.A. de C.V. SOFOM ENR'},
    {'code': '630', 'shortname': 'CB INTERCAM', 'name': 'Intercam Casa de Bolsa, S.A. de C.V'},
    {'code': '631', 'shortname': 'CI BOLSA', 'name': 'CI Casa de Bolsa, S.A. de C.V.'},
    {'code': '632', 'shortname': 'BULLTICK CB', 'name': 'Bulltick Casa de Bolsa, S.A., de C.V.'},
    {'code': '633', 'shortname': 'STERLING', 'name': 'Sterling Casa de Cambio, S.A. de C.V'},
    {'code': '634', 'shortname': 'FINCOMUN', 'name': 'Fincomún, Servicios Financieros Comunitarios, S.A. de C.V.'},
    {'code': '636', 'shortname': 'HDI SEGUROS', 'name': 'HDI Seguros, S.A. de C.V.'},
    {'code': '637', 'shortname': 'ORDER', 'name': 'Order Express Casa de Cambio, S.A. de C.V'},
    {'code': '638', 'shortname': 'AKALA', 'name': 'Akala, S.A. de C.V., Sociedad Financiera Popular'},
    {'code': '640', 'shortname': 'CB JPMORGAN', 'name': 'J.P. Morgan Casa de Bolsa, S.A. de C.V. J.P. Morgan Grupo Financiero'},
    {'code': '642', 'shortname': 'REFORMA', 'name': 'Operadora de Recursos Reforma, S.A. de C.V., S.F.P.'},
    {'code': '646', 'shortname': 'STP', 'name': 'Sistema de Transferencias y Pagos STP, S.A. de C.V.SOFOM ENR'},
    {'code': '647', 'shortname': 'TELECOMM', 'name': 'Telecomunicaciones de México'},
    {'code': '648', 'shortname': 'EVERCORE', 'name': 'Evercore Casa de Bolsa, S.A. de C.V.'},
    {'code': '649', 'shortname': 'SKANDIA', 'name': 'Skandia Operadora de Fondos, S.A. de C.V'},
    {'code': '651', 'shortname': 'SEGMTY', 'name': 'Seguros Monterrey New York Life, S.A de C.V'},
    {'code': '652', 'shortname': 'ASEA', 'name': 'Solución Asea, S.A. de C.V., Sociedad Financiera Popular'},
    {'code': '653', 'shortname': 'KUSPIT', 'name': 'Kuspit Casa de Bolsa, S.A. de C.V.'},
    {'code': '655', 'shortname': 'SOFIEXPRESS', 'name': 'J.P. SOFIEXPRESS, S.A. de C.V., S.F.P'},
    {'code': '656', 'shortname': 'UNAGRA', 'name': 'UNAGRA, S.A. de C.V., S.F.P.'},
    {'code': '659', 'shortname': 'OPCIONES EMPRESARIALES DEL NOROESTE', 'name': 'OPCIONES EMPRESARIALES DEL NORESTE, S.A. DE C.V., S.F.P.'},
    {'code': '670', 'shortname': 'LIBERTAD', 'name': 'Libertad Servicios Financieros, S.A. De C.V.'},
    {'code': '901', 'shortname': 'CLS', 'name': 'Cls Bank International'},
    {'code': '902', 'shortname': 'INDEVAL', 'name': 'SD. Indeval, S.A. de C.V.'},
    {'code': '999', 'shortname': 'LIBERTAD', 'N/A': ''}
  ];

  List<Map<String, dynamic>> _bankPlacesTable = [
    {'code': '010', 'name': ['Aguascalientes']},
    {'code': '012', 'name': ['Calvillo']},
    {'code': '014', 'name': ['Jesús María']},
    {'code': '020', 'name': ['Mexicali']},
    {'code': '022', 'name': ['Ensenada']},
    {'code': '027', 'name': ['Tecate', 'Tijuana']},
    {'code': '028', 'name': ['La Mesa', 'Rosarito', 'Tijuana']},
    {'code': '040', 'name': ['La Paz']},
    {'code': '041', 'name': ['Cabo San Lucas']},
    {'code': '042', 'name': ['Ciudad Constitución']},
    {'code': '043', 'name': ['Guerrero Negro']},
    {'code': '045', 'name': ['San José del Cabo']},
    {'code': '046', 'name': ['Santa Rosalía']},
    {'code': '050', 'name': ['Campeche']},
    {'code': '051', 'name': ['Calkiní']},
    {'code': '052', 'name': ['Ciudad del Carmen']},
    {'code': '053', 'name': ['Champotón']},
    {'code': '060', 'name': ['Gómez Palacio', 'Torreón']},
    {'code': '062', 'name': ['Ciudad Acuña']},
    {'code': '068', 'name': ['Monclova']},
    {'code': '071', 'name': ['Nava']},
    {'code': '072', 'name': ['Nueva Rosita']},
    {'code': '074', 'name': ['Parras de la Fuente']},
    {'code': '075', 'name': ['Piedras Negras']},
    {'code': '076', 'name': ['Ramos Arizpe']},
    {'code': '077', 'name': ['Sabinas']},
    {'code': '078', 'name': ['Saltillo']},
    {'code': '080', 'name': ['San Pedro de las Colonias']},
    {'code': '090', 'name': ['Colima']},
    {'code': '095', 'name': ['Manzanillo']},
    {'code': '097', 'name': ['Tecomán']},
    {'code': '100', 'name': ['Terán', 'Tuxtla Gutiérrez']},
    {'code': '103', 'name': ['Arriaga']},
    {'code': '107', 'name': ['Cintalapa']},
    {'code': '109', 'name': ['Comitán', 'Villa Las Rosas']},
    {'code': '111', 'name': ['Chiapa de Corso']},
    {'code': '113', 'name': ['F. Comalapa']},
    {'code': '114', 'name': ['Huixtla']},
    {'code': '123', 'name': ['Ocosingo']},
    {'code': '124', 'name': ['Ocozocuautla']},
    {'code': '125', 'name': ['Palenque']},
    {'code': '126', 'name': ['Pichucalco']},
    {'code': '127', 'name': ['Pijijiapan']},
    {'code': '128', 'name': ['Reforma']},
    {'code': '130', 'name': ['San Cristóbal de las Casas']},
    {'code': '131', 'name': ['Simojovel']},
    {'code': '133', 'name': ['Tapachula']},
    {'code': '135', 'name': ['Tonala']},
    {'code': '137', 'name': ['Venustiano Carranza']},
    {'code': '138', 'name': ['Villa Flores']},
    {'code': '140', 'name': ['Yajalón']},
    {'code': '150', 'name': ['Chihuahua', 'Ciudad Delicias']},
    {'code': '152', 'name': ['Ciudad Anáhuac']},
    {'code': '155', 'name': ['Ciudad Camargo']},
    {'code': '158', 'name': ['Ciudad Cuauhtémoc']},
    {'code': '161', 'name': ['Ciudad Guerrero']},
    {'code': '162', 'name': ['Parral']},
    {'code': '163', 'name': ['Ciudad Jiménez']},
    {'code': '164', 'name': ['Ciudad Juárez']},
    {'code': '165', 'name': ['Ciudad Madera']},
    {'code': '167', 'name': ['El Molino de Namiquipa']},
    {'code': '168', 'name': ['Nuevo Casas Grandes']},
    {'code': '180', 'name': ['Atizapan', 'Chalco', 'Ciudad de México', 'Coacalco', 'Cuautitlán', 'Cuautitlán Izcalli', 'Ecatepec', 'Huehuetoca', 'Huixquilucan', 'Ixtapaluca', 'Los Reyes La Paz', 'Naucalpan', 'Nezahualcóyotl', 'Tecamac', 'Teotihuacán', 'Texcoco', 'Tlalnepantla']},
    {'code': '190', 'name': ['Durango']},
    {'code': '201', 'name': ['Tepehuanes']},
    {'code': '202', 'name': ['Vicente Guerrero']},
    {'code': '210', 'name': ['Guanajuato']},
    {'code': '211', 'name': ['Abasolo']},
    {'code': '212', 'name': ['Acámbaro']},
    {'code': '213', 'name': ['Apaseo el Alto']},
    {'code': '214', 'name': ['Apaseo el Grande']},
    {'code': '215', 'name': ['Celaya']},
    {'code': '216', 'name': ['Comonfort']},
    {'code': '217', 'name': ['Coroneo']},
    {'code': '218', 'name': ['Cortazar']},
    {'code': '219', 'name': ['Cuerámaro']},
    {'code': '220', 'name': ['Dolores Hidalgo']},
    {'code': '222', 'name': ['Irapuato']},
    {'code': '223', 'name': ['Jaral del Progreso']},
    {'code': '224', 'name': ['Jerécuaro']},
    {'code': '225', 'name': ['León']},
    {'code': '226', 'name': ['Cd. Manuel Doblado']},
    {'code': '227', 'name': ['Moroleón']},
    {'code': '229', 'name': ['Pénjamo']},
    {'code': '232', 'name': ['Romita']},
    {'code': '233', 'name': ['Salamanca']},
    {'code': '234', 'name': ['Salvatierra']},
    {'code': '236', 'name': ['San Felipe']},
    {'code': '237', 'name': ['Purísima de Bustos', 'San Francisco del Rincón']},
    {'code': '238', 'name': ['San José Iturbide']},
    {'code': '239', 'name': ['San Luis de la Paz']},
    {'code': '240', 'name': ['San Miguel Allende']},
    {'code': '244', 'name': ['Silao']},
    {'code': '247', 'name': ['Uriangato']},
    {'code': '248', 'name': ['Valle de Santiago']},
    {'code': '249', 'name': ['Yuriria']},
    {'code': '260', 'name': ['Chilpancingo']},
    {'code': '261', 'name': ['Acapulco']},
    {'code': '263', 'name': ['Arcelia']},
    {'code': '264', 'name': ['Atoyac de Álvarez']},
    {'code': '266', 'name': ['Ciudad Altamirano']},
    {'code': '267', 'name': ['Coyuca de Benítez']},
    {'code': '270', 'name': ['Chilapa']},
    {'code': '271', 'name': ['Huitzuco']},
    {'code': '272', 'name': ['Iguala', 'La Sabana']},
    {'code': '274', 'name': ['Cuajinicuilapa', 'Ometepec']},
    {'code': '275', 'name': ['San Marcos']},
    {'code': '276', 'name': ['Taxco']},
    {'code': '278', 'name': ['Teloloapan']},
    {'code': '281', 'name': ['Tlapa']},
    {'code': '282', 'name': ['Ixtapa Zihuatanejo', 'Zihuatanejo']},
    {'code': '290', 'name': ['Pachuca']},
    {'code': '291', 'name': ['Actopan']},
    {'code': '292', 'name': ['Apam']},
    {'code': '293', 'name': ['Atotonilco el Grande']},
    {'code': '294', 'name': ['Ciudad Sahagún', 'Teocaltiche']},
    {'code': '295', 'name': ['Cuautepec']},
    {'code': '296', 'name': ['Huejutla']},
    {'code': '297', 'name': ['Huichapan']},
    {'code': '298', 'name': ['Ixmiquilpan']},
    {'code': '303', 'name': ['Progreso de Obregón']},
    {'code': '305', 'name': ['Tepeapulco']},
    {'code': '308', 'name': ['Tizayuca']},
    {'code': '311', 'name': ['Tula de Allende']},
    {'code': '312', 'name': ['Tulancingo']},
    {'code': '313', 'name': ['Zacualtipán']},
    {'code': '314', 'name': ['Zimapán']},
    {'code': '320', 'name': ['El Salto', 'Guadalajara', 'San Pedro Tlaquepaque', 'Tlajomulco', 'Tonala', 'Zapopan']},
    {'code': '326', 'name': ['Ameca']},
    {'code': '327', 'name': ['Arandas']},
    {'code': '330', 'name': ['Atotonilco el Alto']},
    {'code': '331', 'name': ['Atequiza']},
    {'code': '333', 'name': ['Autlán']},
    {'code': '340', 'name': ['Casimiro Castillo']},
    {'code': '341', 'name': ['Cihuatlán']},
    {'code': '342', 'name': ['Ciudad Guzmán']},
    {'code': '346', 'name': ['Chapala']},
    {'code': '348', 'name': ['El Grullo']},
    {'code': '355', 'name': ['Ixtlahuacán del Río']},
    {'code': '356', 'name': ['Jalostotitlán']},
    {'code': '357', 'name': ['Jamay']},
    {'code': '361', 'name': ['La Barca']},
    {'code': '362', 'name': ['Lagos de Moreno']},
    {'code': '370', 'name': ['Ocotlán']},
    {'code': '373', 'name': ['Pihuamo']},
    {'code': '375', 'name': ['Las Juntas', 'Nuevo Vallarta', 'Pitillal', 'Puerto Vallarta']},
    {'code': '381', 'name': ['San Juan de los Lagos']},
    {'code': '384', 'name': ['San Miguel el Alto']},
    {'code': '385', 'name': ['San Patricio Melaque']},
    {'code': '386', 'name': ['Sayula']},
    {'code': '387', 'name': ['Tala']},
    {'code': '389', 'name': ['Tamazula de Gordiano']},
    {'code': '391', 'name': ['Tecalitlán']},
    {'code': '396', 'name': ['Tepatitlán']},
    {'code': '397', 'name': ['Tequila']},
    {'code': '403', 'name': ['Tototlán']},
    {'code': '404', 'name': ['Túxpam']},
    {'code': '411', 'name': ['Villa Hidalgo']},
    {'code': '413', 'name': ['Zacoalco de Torres']},
    {'code': '414', 'name': ['Zapotiltic']},
    {'code': '416', 'name': ['Zapotlanejo']},
    {'code': '420', 'name': ['Toluca']},
    {'code': '421', 'name': ['Acambay']},
    {'code': '422', 'name': ['Almoloya de Juárez']},
    {'code': '424', 'name': ['Amecameca']},
    {'code': '425', 'name': ['Apaxco']},
    {'code': '426', 'name': ['Atlacomulco']},
    {'code': '428', 'name': ['Coatepec de Harinas']},
    {'code': '430', 'name': ['Chicoloapan']},
    {'code': '431', 'name': ['Chiconcuac']},
    {'code': '432', 'name': ['El Oro']},
    {'code': '433', 'name': ['Ixtapan de la Sal']},
    {'code': '434', 'name': ['Ixtlahuaca']},
    {'code': '435', 'name': ['Jilotepec']},
    {'code': '438', 'name': ['Lerma']},
    {'code': '441', 'name': ['Metepec']},
    {'code': '443', 'name': ['Otumba']},
    {'code': '445', 'name': ['San Mateo Atenco']},
    {'code': '446', 'name': ['Tejupilco']},
    {'code': '448', 'name': ['Temascaltepec']},
    {'code': '449', 'name': ['Temoaya']},
    {'code': '450', 'name': ['Tenancingo']},
    {'code': '451', 'name': ['Tenago del Valle']},
    {'code': '453', 'name': ['Santiago Tiangistenco']},
    {'code': '455', 'name': ['Tultepec']},
    {'code': '456', 'name': ['Tultitlán']},
    {'code': '457', 'name': ['Valle de Bravo']},
    {'code': '460', 'name': ['Villa Nicolás Romero']},
    {'code': '463', 'name': ['Zumpango']},
    {'code': '470', 'name': ['Morelia']},
    {'code': '472', 'name': ['Aguililla']},
    {'code': '476', 'name': ['Apatzingán']},
    {'code': '480', 'name': ['Ciudad Hidalgo']},
    {'code': '483', 'name': ['Cotija']},
    {'code': '484', 'name': ['Cuitzeo']},
    {'code': '492', 'name': ['Huetamo']},
    {'code': '493', 'name': ['Jacona']},
    {'code': '494', 'name': ['Jiquilpan']},
    {'code': '496', 'name': ['La Piedad']},
    {'code': '497', 'name': ['Lázaro Cárdenas']},
    {'code': '498', 'name': ['Los Reyes']},
    {'code': '499', 'name': ['Maravatío']},
    {'code': '501', 'name': ['Nueva Italia']},
    {'code': '506', 'name': ['Pátzcuaro']},
    {'code': '508', 'name': ['Purépero']},
    {'code': '509', 'name': ['Puruandiro']},
    {'code': '512', 'name': ['Sahuayo']},
    {'code': '515', 'name': ['Tacámbaro']},
    {'code': '517', 'name': ['Tangancícuaro']},
    {'code': '519', 'name': ['Tepalcatepec']},
    {'code': '523', 'name': ['Tlazazalca']},
    {'code': '528', 'name': ['Uruapan']},
    {'code': '533', 'name': ['Yurécuaro']},
    {'code': '534', 'name': ['Zacapu']},
    {'code': '535', 'name': ['Zamora']},
    {'code': '536', 'name': ['Zinapécuaro']},
    {'code': '537', 'name': ['Zitácuaro']},
    {'code': '540', 'name': ['Cuernavaca']},
    {'code': '542', 'name': ['Cuautla', 'Oaxtepec', 'Morelos']},
    {'code': '543', 'name': ['Jiutepec']},
    {'code': '544', 'name': ['Jojutla']},
    {'code': '545', 'name': ['Puente de Ixtla']},
    {'code': '546', 'name': ['Temixco']},
    {'code': '548', 'name': ['Tetecala']},
    {'code': '549', 'name': ['Yautepec']},
    {'code': '552', 'name': ['Zacatepec']},
    {'code': '560', 'name': ['Tepic']},
    {'code': '561', 'name': ['Acaponeta']},
    {'code': '562', 'name': ['Ahuacatlán']},
    {'code': '564', 'name': ['Compostela']},
    {'code': '566', 'name': ['Ixtlán del Río']},
    {'code': '571', 'name': ['San Blas']},
    {'code': '573', 'name': ['Santiago Ixcuintla']},
    {'code': '575', 'name': ['Túxpam']},
    {'code': '580', 'name': ['Apodaca', 'Cadereyta', 'Cd. Guadalupe', 'General Escobedo', 'Monterrey', 'San Nicolás de los Garza', 'San Pedro Garza García', 'Santa Catarina']},
    {'code': '583', 'name': ['Allende']},
    {'code': '592', 'name': ['General Zuazua']},
    {'code': '595', 'name': ['Linares']},
    {'code': '597', 'name': ['Montemorelos']},
    {'code': '599', 'name': ['Sabinas Hidalgo']},
    {'code': '600', 'name': ['Salinas Victoria']},
    {'code': '601', 'name': ['El Cercado', 'Villa de Santiago']},
    {'code': '610', 'name': ['Oaxaca']},
    {'code': '613', 'name': ['Tlaxiaco']},
    {'code': '614', 'name': ['Huajuapan de León']},
    {'code': '616', 'name': ['Ixtepec']},
    {'code': '617', 'name': ['Juchitán']},
    {'code': '619', 'name': ['Loma Bonita']},
    {'code': '620', 'name': ['Matías Romero']},
    {'code': '621', 'name': ['Miahuatlán']},
    {'code': '622', 'name': ['Ocotlán']},
    {'code': '624', 'name': ['Puerto Escondido']},
    {'code': '626', 'name': ['Salina Cruz']},
    {'code': '627', 'name': ['Lagunas']},
    {'code': '628', 'name': ['Tuxtepec']},
    {'code': '630', 'name': ['Pochutla']},
    {'code': '631', 'name': ['San Pedro Tapanatepec']},
    {'code': '632', 'name': ['Santa Lucía del Camino']},
    {'code': '634', 'name': ['Bahías de Huatulco']},
    {'code': '635', 'name': ['Santiago Juxtlahuaca']},
    {'code': '636', 'name': ['Pinotepa Nacional']},
    {'code': '637', 'name': ['Tehuantepec']},
    {'code': '638', 'name': ['Tlacolula']},
    {'code': '640', 'name': ['Zimatlán']},
    {'code': '650', 'name': ['Cholula', 'La Resurrección', 'Puebla', 'San Baltazar Campeche']},
    {'code': '652', 'name': ['Acatzingo']},
    {'code': '654', 'name': ['Atlixco']},
    {'code': '656', 'name': ['Cuetzalan']},
    {'code': '659', 'name': ['Huauchinango']},
    {'code': '662', 'name': ['Izúcar de Matamoros']},
    {'code': '667', 'name': ['San Martín Texmelucan']},
    {'code': '668', 'name': ['San Felipe Hueyotlipan']},
    {'code': '669', 'name': ['Tecamachalco']},
    {'code': '670', 'name': ['Tehuacán']},
    {'code': '671', 'name': ['San Lorenzo']},
    {'code': '672', 'name': ['Teziutlán']},
    {'code': '674', 'name': ['Xicotepec de Juárez']},
    {'code': '676', 'name': ['Zacatlán']},
    {'code': '680', 'name': ['Pedro Escobedo', 'Querétaro', 'Villa Corregidora']},
    {'code': '681', 'name': ['Amealco']},
    {'code': '685', 'name': ['San Juan del Río']},
    {'code': '686', 'name': ['Tequisquiapan']},
    {'code': '690', 'name': ['Chetumal']},
    {'code': '691', 'name': ['Cancún', 'Col. Puerto Juárez']},
    {'code': '692', 'name': ['Cozumel']},
    {'code': '694', 'name': ['Playa del Carmen']},
    {'code': '700', 'name': ['San Luis Potosí']},
    {'code': '703', 'name': ['Cerritos']},
    {'code': '705', 'name': ['Ciudad Valles']},
    {'code': '709', 'name': ['Matehuala']},
    {'code': '711', 'name': ['Río Verde']},
    {'code': '716', 'name': ['Tamuín']},
    {'code': '730', 'name': ['Culiacán']},
    {'code': '735', 'name': ['Concordia']},
    {'code': '736', 'name': ['Cosala']},
    {'code': '737', 'name': ['Choix']},
    {'code': '738', 'name': ['El Fuerte']},
    {'code': '739', 'name': ['Escuinapa']},
    {'code': '740', 'name': ['Guamúchil']},
    {'code': '741', 'name': ['Guasave']},
    {'code': '743', 'name': ['Los Mochis', 'Topolobampo']},
    {'code': '744', 'name': ['Mazatlán']},
    {'code': '745', 'name': ['Mocorito']},
    {'code': '746', 'name': ['Navolato']},
    {'code': '760', 'name': ['Hermosillo']},
    {'code': '761', 'name': ['Agua Prieta']},
    {'code': '765', 'name': ['Caborca']},
    {'code': '766', 'name': ['Cananea']},
    {'code': '767', 'name': ['Ciudad Obregón', 'Esperanza']},
    {'code': '769', 'name': ['Empalme']},
    {'code': '770', 'name': ['Guaymas', 'San Carlos']},
    {'code': '771', 'name': ['Huatabampo']},
    {'code': '773', 'name': ['Magdalena']},
    {'code': '776', 'name': ['Nacozari de García']},
    {'code': '777', 'name': ['Navojoa']},
    {'code': '778', 'name': ['Nogales']},
    {'code': '779', 'name': ['Puerto Peñasco']},
    {'code': '780', 'name': ['San Luis Río Colorado']},
    {'code': '790', 'name': ['Tamulte', 'Villa Hermosa']},
    {'code': '792', 'name': ['Cárdenas']},
    {'code': '793', 'name': ['Ciudad Pemex']},
    {'code': '794', 'name': ['Comalcalco']},
    {'code': '796', 'name': ['Emiliano Zapata']},
    {'code': '797', 'name': ['Frontera']},
    {'code': '798', 'name': ['Huimanguillo']},
    {'code': '800', 'name': ['Jalpa de Méndez']},
    {'code': '802', 'name': ['Macuspana']},
    {'code': '803', 'name': ['Nacajuca']},
    {'code': '804', 'name': ['Paraíso']},
    {'code': '805', 'name': ['Tacotalpa']},
    {'code': '806', 'name': ['Teapa']},
    {'code': '807', 'name': ['Tenosique']},
    {'code': '810', 'name': ['Ciudad Victoria']},
    {'code': '811', 'name': ['Altamira']},
    {'code': '813', 'name': ['Ciudad Madero', 'Tampico']},
    {'code': '814', 'name': ['Ciudad Mante']},
    {'code': '818', 'name': ['Matamoros']},
    {'code': '821', 'name': ['Colombia', 'Nuevo Laredo']},
    {'code': '822', 'name': ['Reynosa']},
    {'code': '823', 'name': ['Río Bravo']},
    {'code': '825', 'name': ['Soto La Marina']},
    {'code': '826', 'name': ['Valle Hermoso']},
    {'code': '830', 'name': ['Tlaxcala']},
    {'code': '832', 'name': ['Apizaco']},
    {'code': '834', 'name': ['Santa Ana Chiautempan']},
    {'code': '840', 'name': ['Jalapa']},
    {'code': '841', 'name': ['Acayucan']},
    {'code': '843', 'name': ['Agua Dulce']},
    {'code': '845', 'name': ['Álamo']},
    {'code': '846', 'name': ['Altotonga']},
    {'code': '848', 'name': ['Banderilla']},
    {'code': '849', 'name': ['Boca del Río']},
    {'code': '852', 'name': ['Ciudad Mendoza']},
    {'code': '853', 'name': ['Coatepec']},
    {'code': '854', 'name': ['Coatzacoalcos']},
    {'code': '855', 'name': ['Córdoba']},
    {'code': '856', 'name': ['Cosamaloapan']},
    {'code': '860', 'name': ['Cuitláhuac']},
    {'code': '863', 'name': ['Fortín de las Flores']},
    {'code': '864', 'name': ['Gutiérrez Zamora']},
    {'code': '865', 'name': ['Huatusco']},
    {'code': '867', 'name': ['Isla']},
    {'code': '868', 'name': ['Ixtaczoquitlán']},
    {'code': '869', 'name': ['Jáltipan']},
    {'code': '871', 'name': ['Juan Rodríguez Clara']},
    {'code': '872', 'name': ['Villa José Cardel']},
    {'code': '873', 'name': ['Las Choapas']},
    {'code': '875', 'name': ['Naranjos']},
    {'code': '876', 'name': ['Martínez de la Torre']},
    {'code': '877', 'name': ['Minatitlán']},
    {'code': '878', 'name': ['Misantla']},
    {'code': '879', 'name': ['Nanchital']},
    {'code': '882', 'name': ['Orizaba']},
    {'code': '885', 'name': ['Papantla']},
    {'code': '886', 'name': ['Perote']},
    {'code': '888', 'name': ['Poza Rica']},
    {'code': '889', 'name': ['Río Blanco']},
    {'code': '890', 'name': ['San Andrés Tuxtla']},
    {'code': '891', 'name': ['San Rafael']},
    {'code': '894', 'name': ['Platón Sánchez', 'Tantoyuca']},
    {'code': '895', 'name': ['Tempoal']},
    {'code': '898', 'name': ['Tierra Blanca']},
    {'code': '901', 'name': ['Tlapacoyan']},
    {'code': '903', 'name': ['Túxpam de Rodríguez Cano']},
    {'code': '905', 'name': ['Cd. Industrial Framboyan', 'Veracruz']},
    {'code': '910', 'name': ['Mérida']},
    {'code': '913', 'name': ['Motul']},
    {'code': '914', 'name': ['Oxkutzcab']},
    {'code': '915', 'name': ['Progreso']},
    {'code': '917', 'name': ['Ticul']},
    {'code': '918', 'name': ['Tizimín']},
    {'code': '920', 'name': ['Valladolid']},
    {'code': '930', 'name': ['Zacatecas']},
    {'code': '933', 'name': ['Fresnillo']},
    {'code': '934', 'name': ['Guadalupe']},
    
    {'code': '935', 'name': ['Jalpa']},
    {'code': '936', 'name': ['Jerez de G. Salinas']},
    {'code': '938', 'name': ['Juchipila']},
    {'code': '939', 'name': ['Loreto']},
    {'code': '946', 'name': ['Nochistlán']},
    {'code': '958', 'name': ['Valparaíso']},
    {'code': '960', 'name': ['Calera de V. Rosales']}
  ];

  static bool isValidClabe({
    required String completeClabe
  }){
  
    //REFERENCIA WEB: https://www.bancanetempresarial.banamex.com.mx/spanishdir/bankhelp/win_archivoscargosdomicilia.htm
    //UNA CLABLE INTERBANCARIA SE COMPONE DE UNA LONGITUD DE 18 CARACTERES
    //LOS 3 PRIMEROS CARACTERES CORRESPONDEN AL CODIGO DE BANCO
    //LOS 3 CARACTERES SIGUIENTES CORRESPONDEN AL CODIGO DE PLAZA DE BANCO
    //LOS 11 CARACTERES SIGUIENTES CORRESPONDEN AL NUMERO DE CUENTA DEL USUARIO (SI FUERAN MENOS DE 11, SE RELLENAN CON CEROS A LA IZQUIERDA)
    //ESTO DA COMO RESULTADO 17 CARACTERES; EL CARACTER 18, QUE ES EL DIGITO DE CONTROL, SE CALCULA EN BASE A LOS PRIMEROS 17 CARACTERES
    completeClabe = completeClabe.trim();
    completeClabe = completeClabe.replaceAll(' ', '');
    if(completeClabe.length == 18) {
    
      final String bankCodeFromCompleteClabe = completeClabe.substring(0, 3); // longitud de 3 digitos
      final String placeBankCodeFromCompleteClabe = completeClabe.substring(3, 6); //longitud de 3 digitos
      final String acountNumberFromCompleteClabe = completeClabe.substring(6, 17); //11 digitos; rellenar con ceros a la izquierda
      final String localClabe = bankCodeFromCompleteClabe + placeBankCodeFromCompleteClabe + acountNumberFromCompleteClabe;

      //Si resultado sale con 'code: 000', quiere decir que no se encontró el banco, y por tanto no es una clabe valida
      final Map<String, String> bankFromTable = ClabeHelper()._banksTable.firstWhere((bank) => bank['code'] == bankCodeFromCompleteClabe, orElse: () => {'code': '000', 'shortname': 'N/A', 'N/A': ''});

      //Si resultado sale con 'code: 000', quiere decir que no se encontró el la plaza de banco, y por tanto no es una clabe valida
      final Map<String, dynamic> bankPlacesFromTable = ClabeHelper()._bankPlacesTable.firstWhere((bank) => bank['code'] == placeBankCodeFromCompleteClabe, orElse: () => {'code': '000', 'name': 'N/A'});

      if(bankFromTable['code'] == '000'){
        print('Clabe no valida');
        return false;
      }

      if(bankPlacesFromTable['code'] == '000'){
        print('Clabe no valida');
        return false;
      }

      print(bankFromTable);
      print(bankPlacesFromTable);
      print(localClabe);

      //1. Se multiplica cada una de las columnas por los pesos 3-7-1 haciendo caso omiso de las decenas
      //XXXXXXXXXXXXXXXXX, entre los numeros de abajo
      //37137137137137137
      //Las decenas, centenas, etc se ignoran, por ejemplo si el resultado de la multiplicación es 42, entonces se pone el 2

      List<int> integerLocalClabe = [];

      localClabe.runes.forEach((charNumCode){
        integerLocalClabe.add(int.parse(String.fromCharCode(charNumCode)));
      });

      print(integerLocalClabe);

      int count = 1;
      List<int> multipliedIntegerLocalClabe = integerLocalClabe.map((num){
        int multipliedNum = 0;
        if(count == 1){
          count = 2;
          multipliedNum = num * 3;
        }
        else if(count == 2){
          count = 3;
          multipliedNum = num * 7;
        }
        else if(count == 3){
          count = 1;
          multipliedNum = num * 1;
        }
        double aux1 = multipliedNum / 10; //Se divide el numero multiplicado entre 10 debido a que queremos saber si el numero es mayor a 10
        int aux2 = aux1.floor(); //Se redondea el resultado de la division anterior
        //Si el resultado es mayor a 0, quiere decir que sobrepasa las decenas, por lo tanto
        //Solo hay que tomas las unidades
        if(aux2 > 0){
          int units = (multipliedNum).remainder(10);
          multipliedNum = units;
        }
        return multipliedNum;
      }).toList();

      print(multipliedIntegerLocalClabe);

      //2. Se suman los resultados en forma horizontal

      int oneNumberMultipliedIntegerLocalClabe = multipliedIntegerLocalClabe.reduce((before, actual){
        return before + actual;
      });

      print(oneNumberMultipliedIntegerLocalClabe);

      //3. Al resultado de la suma tambien se hace caso omiso de las decenas

      double aux3 = oneNumberMultipliedIntegerLocalClabe / 10; //Se divide el numero multiplicado entre 10 debido a que queremos saber si el numero es mayor a 10
      int aux4 = aux3.floor(); //Se redondea el resultado de la division anterior
      //Si el resultado es mayor a 0, quiere decir que sobrepasa las decenas, por lo tanto
      //Solo hay que tomas las unidades
      if(aux4 > 0){
        int units = (oneNumberMultipliedIntegerLocalClabe).remainder(10);
        oneNumberMultipliedIntegerLocalClabe = units;
      }

      print(oneNumberMultipliedIntegerLocalClabe);

      //4. El numero resultante se resta de 10. Si el resultado es 10, el digito de control será 0

      int controlDigit = 10 - oneNumberMultipliedIntegerLocalClabe;

      if(controlDigit == 10) {
        controlDigit = 0;
      }

      print(controlDigit);

      final String finalClabeByAlgorithm = localClabe + controlDigit.toString();

      if(completeClabe == finalClabeByAlgorithm){
        print('Clabe valida: ${finalClabeByAlgorithm}');
        return true;
      }

    } 
    else {
      print('no valida por longitud');
      return false;
    }
    return false;
  }
}