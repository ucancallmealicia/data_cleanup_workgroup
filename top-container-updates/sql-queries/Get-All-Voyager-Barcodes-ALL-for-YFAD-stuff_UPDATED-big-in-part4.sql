SELECT YALEDB.ITEM_BARCODE.ITEM_BARCODE
	, YALEDB.LOCATION.LOCATION_ID
	, YALEDB.LOCATION.LOCATION_NAME
	, YALEDB.BIB_MFHD.BIB_ID
	, YALEDB.BIB_MFHD.MFHD_ID
	, YALEDB.ITEM.ITEM_ID
	, CASE WHEN (YALEDB.MFHD_ITEM.ITEM_ENUM is null OR YALEDB.MFHD_ITEM.ITEM_ENUM = 'Box' OR YALEDB.MFHD_ITEM.ITEM_ENUM = 'Volume') THEN 'assumedbox 1'
	       ELSE YALEDB.MFHD_ITEM.ITEM_ENUM END
	       as ITEM_ENUM
  , YALEDB.ITEM.PERM_LOCATION
  , YALEDB.ITEM_STATS.ITEM_STAT_ID
	
FROM YALEDB.ITEM_BARCODE 
JOIN YALEDB.ITEM ON YALEDB.ITEM_BARCODE.ITEM_ID = YALEDB.ITEM.ITEM_ID
LEFT JOIN YALEDB.ITEM_STATS ON YALEDB.ITEM_STATS.ITEM_ID = YALEDB.ITEM.ITEM_ID
LEFT JOIN YALEDB.ITEM_NOTE ON YALEDB.ITEM_NOTE.ITEM_ID = YALEDB.ITEM.ITEM_ID
JOIN YALEDB.MFHD_ITEM ON YALEDB.MFHD_ITEM.ITEM_ID = YALEDB.ITEM.ITEM_ID
JOIN YALEDB.MFHD_MASTER ON YALEDB.MFHD_MASTER.MFHD_ID = YALEDB.MFHD_ITEM.MFHD_ID
JOIN YALEDB.LOCATION ON YALEDB.LOCATION.LOCATION_ID = YALEDB.MFHD_MASTER.LOCATION_ID 
JOIN YALEDB.BIB_MFHD ON YALEDB.BIB_MFHD.MFHD_ID = YALEDB.MFHD_MASTER.MFHD_ID


WHERE YALEDB.ITEM_BARCODE.BARCODE_STATUS = '1'
AND (YALEDB.BIB_MFHD.BIB_ID in 
('4282845', '4282849', '4317921', '1083408', '1091646', '1091652', '1091653', '1090377', '4282859', '4282868', '4282869', '4282875', '4282880', '4282884', '4282892', '4282895', '4282900', '4282906', '4282913', '4282916', '4294622', '4294624', '4294627', '4294646', '4294648', '4294650', '4294652', '4294654', '4294655', '4294657', '4294658', '4294662', '4294664', '4294665', '4294667', '4294668', '4294669', '4294671', '4294784', '4294785', '4294787', '4294788', '4294790', '4294792', '4294793', '4294794', '4294797', '4294799', '1108265', '4282924', '4282927', '4282931', '4282938', '4282945', '4282951', '4282954', '4282959', '4283142', '4283147', '4283150', '4283154', '4283158', '4283164', '4283170', '4283177', '4283181', '4283184', '4317924', '4283188', '4283193', '4283198', '4283202', '4283207', '4283209', '4283225', '4283229', '4283232', '1097606', '4283233', '972026', '982268', '982269', '982270', '982271', '4283236', '982272', '982273', '982274', '4283240', '982275', '982276', '982279', '1055934', '972028', '4317928', '972029', '1055919', '1029482', '1029485', '1029484', '972030', '934748', '967610', '972031', '1090379', '1065463', '1093072', '1065470', '1065448', '1065441', '1065439', '972032', '1083432', '1087039', '1029486', '1058021', '1053847', '4294803', '4294806', '4294807', '4294811', '4294813', '4294815', '4294818', '4294819', '4283243', '4283245', '4283248', '4283251', '4283253', '1007883', '1007882', '4885936', '1058020', '1029483', '4283360', '4283363', '4283369', '946957', '4283373', '4283374', '4283379', '4283380', '4283386', '4283392', '972034', '4283397', '4283399', '4283403', '4283406', '4283409', '4283415', '4283418', '4283422', '4283424', '4283428', '996997', '1058011', '4283432', '4283506', '4283514', '4283519', '4294822', '4294824', '4294827', '4294836', '4294838', '4294842', '4294844', '4294847', '4294849', '972033', '1100281', '1100282', '1100283', '1100284', '1100285', '4283522', '1100286', '4283527', '1100287', '1109442', '1100288', '1100290', '4283533', '4283539', '1108225', '1108263', '1100289', '1108264', '4283544', '1108222', '1110336', '1090373', '1090374', '1090375', '1090372', '1091643', '1090376', '1090371', '1090369', '1090368', '1090367', '1029480', '1007887', '1009582', '4294853', '4294858', '4294866', '4294881', '4294883', '4294887', '4294889', '4294891', '4294896', '4294898', '4294900', '4294901', '4294905', '4294906', '4294909', '4294912', '4294914', '4294916', '4294918', '4294921', '4294923', '4294926', '4294929', '4294931', '4294932', '4294937', '4294939', '4294941', '4294943', '4294946', '4294948', '4294949', '4294951', '4294958', '4294960', '4294963', '4294966', '4294968', '4294970', '4283548', '4283550', '4283561', '4283571', '982280', '982281', '972035', '982255', '997002', '4283577', '4294973', '982256', '1065440', '1065444', '982257', '4283580', '982258', '982259', '1083409', '1090366', '4283582', '982277', '1110363', '1108221', '4283586', '4283590', '1110338', '4283594', '4283597', '1110337', '1110339', '4283599', '4283602', '1108223', '1108224', '1110340', '1118460', '1110341', '1110342', '4317930', '4283608', '982260', '982278', '982282', '982283', '997003', '4283612', '4283618', '4283624', '982261', '4283628', '4283702', '4283710', '4283712', '982284', '989894', '982285', '982286', '4283724', '982293', '982287', '982288', '4283731', '4283736', '4283740', '4283745', '982262', '4283748', '1055930', '1055931', '1055933', '1055909', '1058036', '1055910', '1055911', '1055912', '1055913', '1058037', '1055916', '1055915', '1055914', '1055904', '1055903', '1055905', '1055902', '1055901', '1055900', '1053853', '1055899', '1055898', '1091663', '4294989', '1091661', '1091662', '1091660', '1084878', '1084879', '1084883', '4294993', '4283752', '4283755', '4294997', '4294998', '4295002', '4295004', '4295008', '4295013', '1084876', '1084880', '4295023', '4295027', '1084882', '1084881', '1084874', '1084875', '4295030', '4295034', '4295039', '1090370', '1096675', '1065445', '1093073', '1065446', '1065443', '4317950', '1083404', '1083405', '1065456', '982263', '1093075', '1009575', '1029479', '1009580', '1029481', '1004538', '4283763', '1004537', '1007877', '1009576', '4283765', '982264', '4283771', '4283775', '1091649', '4295043', '1091651', '1091650', '1091648', '1083415', '1083414', '1089279', '1083433', '982265', '1007886', '1029474', '4283779', '4283781', '4283788', '4283790', '4283793', '4283798', '1089280', '1087040', '1089276', '1083431', '1083429', '1083430', '1094377', '1094378', '1094379', '1094380', '1094381', '1094382', '1094383', '1097604', '1094384', '1094385', '4295056', '4295058', '4295064', '4295066', '4295067', '4295074', '4295301', '4295305', '4295306', '4295308', '982267', '1094390', '1094391', '1094392', '1094373', '4295315', '4295317', '4295322', '4295323', '4295326', '4295329', '4295332', '1089288', '1083434', '1089235', '1089287', '1089233', '1089234', '1089237', '1089247', '1088185', '1088186', '1088184', '1088189', '4283914', '4283918', '4283921', '994994', '4283929', '4283934', '4283936', '4283938', '4283941', '4283945', '1088183', '1089246', '1089245', '1089238', '1089249', '1089240', '1089241', '1089252', '1089250', '1089242', '1089244', '989906', '1094372', '994998', '994989', '994992', '992507', '994991', '992510', '4283953', '1094368', '1094371', '1098948', '1100250', '4295351', '1108255', '1100255', '4295358', '4295361', '1089236', '1083428', '1089278', '1091665', '4283957', '4283961', '4295363', '4295369', '4295370', '4295372', '4295375', '4295376', '4295379', '4295382', '4295383', '4295387', '996994', '994997', '4295392', '4295397', '4295398', '997000', '4295402', '4283963', '1118455', '1118456', '1118457', '1118458', '4295403', '4295406', '4295410', '4295413', '1118459', '4283968', '4295414', '4295421', '4295424', '4295427', '4295461', '4295467', '4295470', '4295474', '4295476', '4283971', '4295478', '1093086', '1093087', '1094365', '1094366', '1094367', '1093081', '1094369', '1094370', '1055897', '4295667', '4295672', '4295673', '4295674', '4295676', '4295678', '4295679', '4295685', '4295687', '4295689', '4295691', '4295694', '4295695', '4295696', '4295701', '4295704', '4295706', '4295709', '4295710', '4295712', '4295714', '4295716', '4295717', '4295724', '4295728', '4295730', '4295732', '4295739', '4295742', '4295747', '4295750', '4295752', '4295774', '4295777', '1029473', '4295781', '4295785', '4295787', '4295788', '4295790', '4295792', '4295794', '4295796', '4295798', '4295799', '4295802', '4295805', '4295806', '4295809', '4295811', '4295816', '4295819', '4295820', '1072617', '1007875', '1084877', '1087036', '1087038', '1087041', '1087037', '1091664', '1091700', '1089248', '1089253', '1089251', '1089255', '1089254', '1007874', '4283976', '4283981', '4283999', '4284000', '1091696', '4317953', '1091694', '1091690', '1091693', '1007878', '1091644', '1091642', '1009581', '1089275', '1091698', '1058042', '1089277', '1088191', '1088179', '1089283', '1091701', '1110362', '4284005', '4284008', '4284012', '4284015', '4284017', '1110358', '1110359', '4284019', '4284024', '4284027', '4284036', '4284040', '4284044', '1110360', '4284046', '4284047', '1108260', '4284077', '1110344', '1072610', '1110345', '1110361', '4284083', '1110346', '1110353', '1113637', '4284087', '4284090', '4284094', '4284097', '4284099', '4284103', '4284106', '4284112', '1113648', '4284115', '4284123', '4284126', '4284128', '4295945', '4295947', '4295949', '4295952', '4295956', '4295957', '4295961', '4295963', '4295966', '4295969', '4295972', '4295976', '4295978', '4295981', '4295983', '4295987', '4295989', '4295991', '4295994', '4295996', '4295997', '4296000', '4296002', '4296005', '4296007', '4296008', '4296010', '4296013', '4296015', '1029489', '4296017', '4296018', '4296021', '4296023', '4317582', '4317601', '4317609', '4317617', '4317623', '4317631', '4317636', '4317641', '4317645', '4317647', '4317651', '4317658', '4317663', '4317750', '4317763', '4317764', '4317771', '4317777', '4317782', '4317784', '4317785', '4317792', '4317797', '4317801', '4317803', '4317805', '4317809', '4317812', '4317819', '4317821', '4317824', '4317828', '4317832', '4317835', '4317842', '4317845', '4317853', '4317857', '4317860', '4317864', '4296121', '4284132', '4296122', '4296125', '4296127', '4296129', '4296130', '4296132', '4296133', '4296136', '4296137', '4296138', '4296140', '4296142', '4296149', '4296151', '4296154', '4296155', '4296159', '4296162', '4296163', '4296164', '4296167', '4296170', '4284135', '4296174', '4284138', '4296177', '4296179', '4284147', '4284153', '4284304', '4284309', '4284315', '4284319', '4284324', '4284327', '4284338', '4284342', '4284347', '4284353', '4284359', '4284364', '4284369', '4284376', '4284382', '4284387', '4284393', '4284398', '4284401', '4284541', '4284551', '4284554', '4284560', '4284564', '4284570', '4284576', '4284586', '4284590', '4284596', '4284603', '4284609', '4296188', '4296189', '4296192', '4296196', '4296200', '4296202', '4296204', '4296207', '4296208', '4296209', '4296211', '4284612', '4296213', '4296214', '4284616', '1055896', '4284619', '4284623', '4284695', '4284698', '4284702', '4284708', '4284712', '4284718', '4284722', '4284725', '4284729', '4284732', '4284737', '4284738', '4284740', '4284744', '4284746', '4284749', '4284750', '4284934', '4284936', '4284939', '4318051', '4284946', '4284949', '4284951', '4284952', '1072606', '1053852', '1053851', '1053850', '1072608', '4284954', '4284956', '4284960', '4284965', '4284989', '4284991', '4284992', '4284996', '4296318', '1072605', '1065462', '1065451', '1053849', '1053848', '1065455', '1072622', '1072623', '1072619', '1072618', '1072621', '4285002', '4285006', '1083402', '4285013', '4285015', '4285022', '4285023', '4296322', '4285025', '4285134', '4285136', '4285139', '4285145', '4285146', '4285149', '4285154', '4285158', '4285161', '4285167', '4285170', '4296333', '4285174', '4285180', '4285184', '4285192', '1096676', '4285197', '4296337', '4285206', '4285213', '4285215', '4285217', '4285220', '4285225', '1072620', '4285228', '4285231', '4285233', '4296340', '4296342', '4296347', '4296351', '4296353', '4296356', '4296362', '4285236', '4285374', '4285377', '4285380', '4285382', '4285386', '4285389', '4285391', '4285395', '4285396', '4285399', '4285401', '4285402', '4285404', '4285406', '4285407', '4296366', '4296370', '4296372', '4296379', '4296382', '4296385', '1090380', '4285410', '1097611', '1097614', '4285414', '4285415', '4285419', '4285421', '4285422', '4285425', '4285430', '4285433', '4285436', '4285858', '4285861', '4285864', '4285867', '4285869', '4285870', '4285873', '4285876', '4285878', '4285882', '4285886', '4285890', '4285891', '4285894', '4296392', '4285897', '4285900', '4285903', '4285905', '4285908', '4285910', '4285913', '4285916', '4285917', '4285919', '4285921', '4285925', '4285927', '4285928', '1065450', '4285932', '4285989', '4285992', '4285997', '4286002', '4286004', '4286008', '4286012')
OR YALEDB.BIB_MFHD.BIB_ID in
('4286015', '4286018', '4286021', '4286022', '4286023', '4286027', '4286028', '4286030', '4286033', '4286035', '4286037', '4286039', '4286042', '1065464', '4286045', '4286047', '4286053', '4286055', '4286059', '4286060', '4286062', '4286065', '4286067', '1065453', '4286070', '4286075', '4286081', '4286084', '4286086', '4286089', '4286095', '4286097', '4286101', '4286103', '4286106', '4286109', '4286113', '4286285', '4286288', '4286289', '4286292', '4286296', '4286299', '4286302', '4286304', '4286306', '4286308', '4286311', '4286317', '4286321', '4286323', '4286324', '4286325', '4286329', '4286330', '4286333', '4286336', '4286338', '4286341', '4286342', '4286345', '4286346', '4286348', '1065465', '4286355', '1072609', '4286356', '4286358', '4286361', '4286363', '4286365', '4286367', '4286369', '4286372', '4286375', '1100268', '4286379', '4286381', '1100269', '4286386', '4286387', '1100279', '1111971', '4286390', '4296398', '4296402', '4296403', '4296405', '4296410', '4296418', '4296421', '4296423', '4296424', '4296428', '4296429', '4296431', '4296433', '4296448', '4296449', '4296452', '4296557', '4296558', '4296560', '4296561', '4296562', '4296564', '4296567', '4296568', '4296569', '4296570', '4296571', '4296574', '4296575', '4296576', '4296578', '4296579', '4296581', '4296591', '4296593', '4296594', '4296595', '4296596', '1065452', '1065454', '1065466', '1072611', '1072613', '4286392', '4286394', '4286396', '4286398', '4286400', '4286560', '4286563', '4286565', '4286567', '4286573', '4318257', '4286578', '4286584', '4286587', '1108266', '4286590', '1108267', '4318094', '4286598', '4286603', '4286606', '4286608', '4286609', '4838018', '4286610', '4286612', '4286614', '4286622', '4286626', '4286635', '4286639', '4318103', '4286641', '4286642', '4286644', '1065458', '1065442', '1065447', '1100251', '4296601', '4296602', '4296603', '4286652', '1109444', '4296604', '4286649', '1100267', '4296606', '4296607', '4296608', '4296609', '4296610', '4296612', '4296614', '4296616', '4296618', '4296620', '4296622', '4296624', '4296626', '4286650', '1100252', '4296630', '4296631', '4296633', '4296634', '4296636', '4296643', '4296644', '4286659', '4286662', '4286666', '4286667', '4286671', '4286672', '4286675', '4286677', '4286797', '4286808', '4286811', '4286816', '4286819', '4286824', '4286827', '4286829', '4286831', '4286835', '4286862', '4287033', '4287044', '4287046', '4287049', '4287053', '4287056', '4287059', '4287064', '4287067', '4287069', '4287075', '4287077', '4287080', '4287087', '1072614', '1068951', '1072616', '1065457', '1090378', '1072607', '1091647', '4296675', '4296677', '1094362', '1094363', '4287094', '1096667', '1094364', '1093083', '1093085', '1093084', '1093082', '4287100', '4287209', '4287212', '4296687', '4296689', '4296692', '4296693', '4296694', '4296695', '4296697', '1091681', '1091680', '1091679', '1091678', '1091674', '1091673', '1094393', '1089239', '4287217', '4287220', '4287223', '4287229', '4296698', '4287232', '4287236', '4287242', '4287250', '4287262', '4287263', '4287265', '4287269', '1113649', '4287272', '4287275', '4287282', '4287289', '4287292', '4287299', '1113638', '1113639', '1113640', '4287303', '1113641', '1113642', '1108261', '1113643', '4287313', '4287317', '4287318', '4287321', '4287324', '4287328', '4287354', '4287356', '4287358', '4287365', '4287366', '1096673', '1096671', '1096672', '1100256', '1096677', '1096678', '1096679', '1065469', '4296709', '4296710', '1065468', '1072612', '4296713', '4318148', '4318151', '4296714', '1090365', '1065449', '1065467', '1072615', '1097607', '1083425', '1083426', '4287369', '1091669', '1091670', '1091671', '4296716', '4296717', '4296718', '4296719', '4296721', '4296722', '4296723', '4296725', '4296726', '4296728', '4296730', '4296731', '4296734', '4296739', '4296740', '4296743', '4296747', '4296748', '4296750', '4296752', '4296755', '4296756', '4296757', '4296759', '4296760', '4296763', '4296764', '4296765', '4296767', '4296768', '4296770', '4296798', '4296799', '4296800', '4296801', '4296802', '4318153', '4296803', '4296805', '4296806', '4296807', '4296809', '4296810', '4296813', '4287435', '4287439', '1094394', '1096663', '1094395', '1096680', '1091667', '1091666', '1091668', '1083423', '1083427', '1083424', '1083420', '4287446', '4287449', '4287458', '4287464', '4287469', '4287473', '4287476', '4287479', '4287491', '4287495', '4287508', '4287510', '4287515', '4287519', '4287523', '4287526', '4287530', '4287535', '1091691', '1091692', '1091689', '1091685', '1091688', '1091687', '1091686', '1094376', '1094375', '1096681', '1094374', '1094396', '1094397', '1094386', '1094387', '1094388', '1094398', '1096674', '1096669', '1094389', '1096682', '1096660', '1096683', '1096684', '4296815', '4296816', '4296817', '4287541', '1096685', '1096670', '1097618', '4287544', '4287548', '4287559', '4287565', '4287570', '4287575', '4287580', '4287587', '4287592', '4287597', '1096661', '1096662', '1096686', '1096668', '1096687', '1096665', '1096664', '1096666', '1100253', '4287620', '1096688', '1096689', '1097608', '1097609', '1097610', '4296823', '4296824', '4296826', '4296827', '4296830', '4296832', '4296833', '4296835', '4296836', '4296839', '4296841', '4296842', '4296845', '4296847', '4296849', '4318155', '4318158', '4318162', '4318164', '4318169', '4318173', '4318176', '4318178', '4296852', '4296854', '4287628', '4287756', '4287759', '4287761', '4287765', '4287767', '4287772', '4287774', '4287777', '4287779', '4287784', '4287788', '4287792', '4287799', '4287800', '4287801', '4287806', '4287809', '4287810', '4318182', '4287819', '4287826', '4287829', '4287831', '4287833', '4287839', '4287841', '4287845', '4287854', '4287856', '4287860', '4287867', '4287870', '4287871', '4287875', '1093079', '1093077', '4288031', '4288035', '4288039', '4288043', '4288046', '4288051', '4288053', '4288056', '4288060', '4288063', '4288067', '4296865', '4296867', '4288078', '4288081', '4288191', '4288192', '4288197', '4288201', '4288206', '4288208', '4288211', '4288216', '4288228', '4288230', '4288233', '4296875', '4288237', '4288242', '4288243', '4288246', '4288249', '4288251', '4288254', '4288258', '4288262', '4288264', '4288265', '4288267', '4288269', '4288272', '4296877', '4288280', '4288282', '4288286', '4288291', '4288294', '4288300', '4288304', '4288305', '4288308', '4296878', '4288310', '4288317', '4288318', '1097612', '1097616', '1097617', '4296881', '4296901', '4296902', '4296903', '4296908', '4296912', '4296914', '4296916', '4296917', '4296918', '4296921', '4296922', '4296925', '4296927', '4296928', '4296930', '4296932', '4288445', '4288449', '4296934', '4296936', '4288450', '4288453', '4288455', '4288457', '4296939', '4288458', '4288460', '4296941', '4288463', '4296942', '4288469', '4288470', '4288473', '4288476', '4288477', '4288480', '4288482', '4288483', '4288487', '4288490', '4288493', '1109445', '4288498', '1109446', '4288501', '1109447', '1109448', '1109449', '1109450', '1109451', '1109452', '4288510', '4288514', '4288517', '1109435', '4288523', '4288526', '4288529', '1109436', '1097620', '4288531', '1109443', '4288533', '1108226', '4288535', '4288539', '1109439', '1091659', '4288542', '1091658', '1091654', '4288623', '4288625', '4288626', '4288628', '4288631', '4288633', '4288636', '4288640', '4288643', '4288644', '4288647', '4288649', '4288650', '4288652', '4288655', '4288656', '4288660', '4288662', '4288664', '4288669', '4288671', '4288676', '4288677', '4288679', '4288684', '4288686', '4288690', '4288693', '4288695', '4288701', '4288703', '4288704', '4288708', '4288710', '4288714', '4288716', '4288719', '4288722', '4288726', '4288745', '1091699', '1087042', '1084884', '4296948', '4288747', '4296953', '4296955', '4296957', '4296959', '4296961', '4296964', '4296965', '4296970', '4296973', '4296975', '4296978', '1089284', '1088180', '1088178', '1089285', '1089259', '1089258', '1089257', '1091695', '4296980', '4296982', '4296984', '4296986', '4296989', '4296991', '4296992', '1089286', '1089243', '1089260', '4288754', '1088182', '1088181', '1088190', '1088192', '1093078', '1093080', '1089256', '1093088', '4288758', '4296996', '4288760', '4288762', '4288763', '4288764', '4288765', '4288766', '4288767', '4288769', '4288771', '4288772', '4288773', '4288775', '4288776', '4288777', '4288779', '4288783', '4288784', '4288786', '4288788', '4288789', '4288790', '4288791', '4288793', '4288795', '4297004', '4288797', '4288798', '4288800', '4297008', '4297011', '4297070', '4297072', '4297073', '4288803', '4288806', '4288807', '4288827', '4288828', '4288832', '1089261', '1089262', '4288833', '4288835', '4288905', '4288907', '4288908', '4288912', '1091684', '1089263', '4288917', '1109437', '1109438', '1113635', '1113636', '4288920', '1097619', '4288921', '4288923', '4288927', '4288928', '4288929', '1091683', '1089264', '1089265', '1089266', '4297075', '4297076', '4288931', '4297079', '4297080', '1091675', '4288935', '4288936', '4288939', '4288940', '4288941', '4288944', '4288946', '4288947', '4288949', '4288951', '4288953', '4288955', '4288958', '1091676', '1091682', '1091677', '4297087', '4297088', '4297091', '4297094', '4297095', '4297096', '4297098', '4297101', '4297103', '4297106', '4297107', '4288959', '4288961', '4297109', '4288962', '4288964', '4288968', '4297114', '4288969', '4289068', '4289070', '4289071', '4289074', '4289077', '4289079', '4289081', '4289085', '4289086', '4289088', '4289090', '4289093', '4289096', '4289097', '4289101', '4289104', '4289106', '4297117', '4297118', '4289109', '4289112', '4289116', '4289120', '4289123', '4289130', '4289132', '4289210', '4289215', '4289218', '4289222', '4289225', '4289236', '4289240', '4289242', '4289244', '4289246', '4289247', '4289248', '4289250', '4289252', '4289255', '4289258', '4289260', '4289267', '4289271', '4289273', '4289274', '4289276', '4289277', '4289283', '4289289', '4289290', '4289292', '4289294', '4289297', '4289298', '4289303', '4289311', '4289313', '4289317', '4289319', '4289323', '4289329', '4289331', '4289333', '4289337', '4289340', '4289343', '4289345', '4289350', '4289353', '4289357', '4289363', '4289369', '4289391', '4289397', '4289402', '4289403', '4289409', '4289411', '4289415', '4289898', '4289900', '4289902', '4289903', '4289905', '4289907', '4289909', '4289910', '4289914', '4289916', '4289918', '4289919', '4297123', '4297124', '4297127', '4297129', '4297131', '4289923', '4289924', '4289926', '4289928', '4289929', '4289930', '4289931', '4289933', '4289934', '4289936', '4289937', '4289938', '4289939', '4289941', '4289942', '4289944', '4289945', '4289949', '4289951', '4289953', '4289955', '4289957', '4289959', '4289961', '4289963', '4289966', '4290022', '4290025', '4290028', '4290029', '4290032', '4290053', '4290055', '4290058', '4290061', '4290062', '4290064', '4290067', '4290072', '4290074', '4290076', '4290077', '4290078', '4290081', '4290083', '4290085', '4290086', '4290088', '4290089', '4290091', '4290092', '4290094', '4290096', '4290100', '4290101', '4290103', '4290104')
)
