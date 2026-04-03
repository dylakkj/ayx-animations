-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
AnimTable = {

	["passinhodojamal"] = { 
		category = "dance", 
		dict = "passinhodojamal@animation", 
		anim = "passinhodojamal_clip", 
		walk = false, loop = true 
	},

	["forro1"] = { category = "shared", dict = "pandora@authenticv1@bachata1", anim = "pandora_male", target_emote = "forro1couple", loop = true, walk = false },
	["forro1couple"] = { category = "shared", dict = "pandora@authenticv1@bachata1", anim = "pandora_fem", target_emote = "forro1", loop = true, walk = false, hide = true,
		offset = {
			x = 0.0,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		} 
	},

	["bandeirahypefolia"] = { 
		category = "normal", 
		dict = "rcmnigel1d", 
		anim = "base_club_shoulder", 
		prop = "hype_folia_flag1", 
		walk = true, loop = true,
		flag = 49, mao = 28422, pos1 = 0.12, pos2 = 0.02, pos3 = 0.15, pos4 = 176, pos5 = -37, pos6 = 2
	},
	["bandeirahypefolia2"] = { 
		category = "normal", 
		dict = "rcmnigel1d", 
		anim = "base_club_shoulder", 
		prop = "hype_folia_flag2",
		walk = true, loop = true,
		flag = 49, mao = 28422, pos1 = 0.12, pos2 = 0.02, pos3 = 0.15, pos4 = 176, pos5 = -37, pos6 = 2
	},
	["bandeirablocodescequebra"] = { 
		category = "normal", 
		dict = "rcmnigel1d", 
		anim = "base_club_shoulder", 
		prop = "hype_folia_flag3",
		walk = true, loop = true,
		flag = 49, mao = 28422, pos1 = 0.12, pos2 = 0.02, pos3 = 0.15, pos4 = 176, pos5 = -37, pos6 = 2
	},
	["bandeirablocojadeurr"] = { 
		category = "normal", 
		dict = "rcmnigel1d", 
		anim = "base_club_shoulder", 
		prop = "hype_folia_flag4",
		walk = true, loop = true,
		flag = 49, mao = 28422, pos1 = 0.12, pos2 = 0.02, pos3 = 0.15, pos4 = 176, pos5 = -37, pos6 = 2
	},
	["bandeirabloconaomebane"] = { 
		category = "normal", 
		dict = "rcmnigel1d", 
		anim = "base_club_shoulder", 
		prop = "hype_folia_flag5",
		walk = true, loop = true,
		flag = 49, mao = 28422, pos1 = 0.12, pos2 = 0.02, pos3 = 0.15, pos4 = 176, pos5 = -37, pos6 = 2
	},
	["caixadecarnaval"] = { 
		category = "normal", 
		dict = "anim@heists@box_carry@", 
		anim = "idle", 
		prop = "hype_folia_box",
		walk = true, loop = true,
		flag = 50, mao = 60309, altura = 0.025, pos1 = 0.08, pos2 = 0.255, pos3 = -50.0, pos4 = 290.0, pos5 = 0.0 
	},

	["pose"] = { category = "normal", dict = "pose@seimen", anim = "pose_clip", andar = false, loop = true },	
	["pose2"] = { category = "normal", dict = "pose2@seimen", anim = "pose2_clip", andar = false, loop = true },
	["pose3"] = { category = "normal", dict = "pose3@seimen", anim = "pose3_clip", andar = false, loop = true },
	["pose4"] = { category = "normal", dict = "pose4@seimen", anim = "pose4_clip", andar = false, loop = true },	
	["pose5"] = { category = "normal", dict = "pose5@seimen", anim = "pose5_clip", andar = false, loop = true },
	["pose6"] = { category = "normal", dict = "pose6@seimen", anim = "pose6_clip", andar = false, loop = true },
	["pose7"] = { category = "normal", dict = "pose7@seimen", anim = "pose7_clip", andar = false, loop = true },	
	["pose8"] = { category = "normal", dict = "pose8@seimen", anim = "pose8_clip", andar = false, loop = true },
	["pose9"] = { category = "normal", dict = "pose9@seimen", anim = "pose9_clip", andar = false, loop = true },

	["pose"] = { category = "normal", dict = "pose@seimen", anim = "pose_clip", andar = false, loop = true },	
	["pose2"] = { category = "normal", dict = "pose2@seimen", anim = "pose2_clip", andar = false, loop = true },
	["pose3"] = { category = "normal", dict = "pose3@seimen", anim = "pose3_clip", andar = false, loop = true },
	["pose4"] = { category = "normal", dict = "pose4@seimen", anim = "pose4_clip", andar = false, loop = true },	
	["pose5"] = { category = "normal", dict = "pose5@seimen", anim = "pose5_clip", andar = false, loop = true },
	["pose6"] = { category = "normal", dict = "pose6@seimen", anim = "pose6_clip", andar = false, loop = true },
	["pose7"] = { category = "normal", dict = "pose7@seimen", anim = "pose7_clip", andar = false, loop = true },	
	["pose8"] = { category = "normal", dict = "pose8@seimen", anim = "pose8_clip", andar = false, loop = true },
	["pose9"] = { category = "normal", dict = "pose9@seimen", anim = "pose9_clip", andar = false, loop = true },

	["pose10"] = { category = "normal", dict = "instagrampose@seimen", anim = "instagrampose_clip", andar = false, loop = true },	
	["pose11"] = { category = "normal", dict = "instagrampose2@seimen", anim = "instagrampose2_clip", andar = false, loop = true },
	["pose12"] = { category = "normal", dict = "instagrampose3@seimen", anim = "instagrampose3_clip", andar = false, loop = true },
	["pose13"] = { category = "normal", dict = "instagrampose4@seimen", anim = "instagrampose4_clip", andar = false, loop = true },	
	["pose14"] = { category = "normal", dict = "instagrampose12@seimen", anim = "instagrampose12_clip", andar = false, loop = true },
	["pose15"] = { category = "normal", dict = "instagrampose13@seimen", anim = "instagrampose13_clip", andar = false, loop = true },
	["pose16"] = { category = "normal", dict = "instagrampose14@seimen", anim = "instagrampose14_clip", andar = false, loop = true },	
	["pose17"] = { category = "normal", dict = "instagrampose15@seimen", anim = "instagrampose15_clip", andar = false, loop = true },
	["pose18"] = { category = "normal", dict = "instagrampose16@seimen", anim = "instagrampose16_clip", andar = false, loop = true },

	["sentar"] = { category = "normal", dict = "customposesit@queensisters", anim = "custompose_clip", andar = false, loop = true },
	["sentar2"] = { category = "normal", dict = "customposesit2@queensisters", anim = "posesit_clip", andar = false, loop = true },

	-------------------------------
	-- FORTNITE
	-------------------------------

	["ftn1"] = { category = "dance", dict = "pfflytotokyo@animations", anim = "pfflytotokyoclip", walk = false, loop = true },
	["ftn2"] = { category = "dance", dict = "pfattraction@animations", anim = "pfattractionclip", walk = false, loop = true },
	["ftn3"] = { category = "dance", dict = "pfluciddreams@animations", anim = "pfluciddreamsclip", walk = false, loop = true },
	["ftn4"] = { category = "dance", dict = "pfskeledance@animations", anim = "pfskeledanceclip", walk = false, loop = true },
	["ftn5"] = { category = "dance", dict = "pftheviper@animations", anim = "pftheviperclip", walk = false, loop = true },
	["ftn6"] = { category = "dance", dict = "pfgethot@animations", anim = "pfgethotclip", walk = false, loop = true },
	["ftn7"] = { category = "dance", dict = "pfemptyoutyourpockets@animations", anim = "pfemptyoutyourpocketsclip", walk = false, loop = true },
	["ftn8"] = { category = "dance", dict = "pfrapmonster@animations", anim = "pfrapmonsterclip", walk = false, loop = true },
	["ftn9"] = { category = "dance", dict = "pfmaskoff@animations", anim = "pfmaskoffclip", walk = false, loop = true },
	["ftn10"] = { category = "dance", dict = "pfnuthinbutagthang@animations", anim = "pfnuthinbutagthangclip", walk = false, loop = true },
	["ftn11"] = { category = "dance", dict = "pfcoffin@animations", anim = "pfcoffinclip", walk = false, loop = true },
	["ftn12"] = { category = "dance", dict = "pfcoffinmove@animations", anim = "pfcoffinmoveclip", walk = false, loop = true },
	["ftn13"] = { category = "dance", dict = "pfcalifornialove@animations", anim = "pfcalifornialoveclip", walk = false, loop = true },
	["ftn14"] = { category = "dance", dict = "pfbyebyebye@animations", anim = "pfbyebyebyeclip", walk = false, loop = true },
	["ftn15"] = { category = "dance", dict = "pfsoarabove@animations", anim = "pfsoaraboveclip", walk = false, loop = true },
	["ftn16"] = { category = "dance", dict = "pfalliwantforchristmas@animations", anim = "pfalliwantforchristmasclip", walk = false, loop = true },
	["ftn17"] = { category = "dance", dict = "pfriches@animations", anim = "pfrichesclip", walk = false, loop = true },
	["ftn18"] = { category = "dance", dict = "pfdesirable@animations", anim = "pfdesirableclip", walk = false, loop = true },
	["ftn19"] = { category = "dance", dict = "pftakeitslow@animations", anim = "pftakeitslowclip", walk = false, loop = true },
	["ftn20"] = { category = "dance", dict = "pfthedog@animations", anim = "pfthedogclip", walk = false, loop = true },
	["ftn21"] = { category = "dance", dict = "pfsnoopswalk@animations", anim = "pfsnoopswalkclip", walk = false, loop = true },
	["ftn22"] = { category = "dance", dict = "pfrhythmofchaos@animations", anim = "pfrhythmofchaosclip", walk = false, loop = true },
	["ftn23"] = { category = "dance", dict = "pfmoongazer@animations", anim = "pfmoongazerclip", walk = false, loop = true },
	["ftn24"] = { category = "dance", dict = "pfcaffeinated@animations", anim = "pfcaffeinatedclip", walk = false, loop = true },
	["ftn25"] = { category = "dance", dict = "pfcaffeinatedold@animations", anim = "pfcaffeinatedoldclip", walk = false, loop = true },
	["ftn26"] = { category = "dance", dict = "pfcommitted@animations", anim = "pfcommittedclip", walk = false, loop = true },
	["ftn27"] = { category = "dance", dict = "pfdimensional@animations", anim = "pfdimensionalclip", walk = false, loop = true },
	["ftn28"] = { category = "dance", dict = "pfmikulive@animations", anim = "pfmikuliveclip", walk = false, loop = true },
	["ftn29"] = { category = "dance", dict = "pffeelit@animations", anim = "pffeelitclip", walk = false, loop = true },
	["ftn30"] = { category = "dance", dict = "pfstartingprance@animations", anim = "pfstartingpranceclip", walk = false, loop = true },
	["ftn31"] = { category = "dance", dict = "pfskyward@animations", anim = "pfskywardclip", walk = false, loop = true },
	["ftn32"] = { category = "dance", dict = "pfsmoothoperator@animations", anim = "pfsmoothoperatorclip", walk = false, loop = true },
	["ftn33"] = { category = "dance", dict = "pfbratty@animations", anim = "pfbrattyclip", walk = false, loop = true },
	["ftn34"] = { category = "dance", dict = "pfinhamood@animations", anim = "pfinhamoodclip", walk = false, loop = true },
	["ftn35"] = { category = "dance", dict = "pfspicystart@animations", anim = "pfspicystartclip", walk = false, loop = true },
	["ftn36"] = { category = "dance", dict = "pfdeepexplorer@animations", anim = "pfdeepexplorerclip", walk = false, loop = true },
	["ftn37"] = { category = "dance", dict = "pfwhatyouwant@animations", anim = "pfwhatyouwantclip", walk = false, loop = true },
	["ftn38"] = { category = "dance", dict = "pflinedancin@animations", anim = "pflinedancinclip", walk = false, loop = true },
	["ftn39"] = { category = "dance", dict = "pfindependence@animations", anim = "pfindependenceclip", walk = false, loop = true },
	["ftn40"] = { category = "dance", dict = "pfcairo@animations", anim = "pfcairoclip", walk = false, loop = true },
	["ftn41"] = { category = "dance", dict = "pfokidoki@animations", anim = "pfokidokiclip", walk = false, loop = true },
	["ftn42"] = { category = "dance", dict = "pfoutlaw@animations", anim = "pfoutlawclip", walk = false, loop = true },
	["ftn43"] = { category = "dance", dict = "pfnotears@animations", anim = "pfnotearsclip", walk = false, loop = true },
	["ftn44"] = { category = "dance", dict = "pfmine@animations", anim = "pfmineclip", walk = false, loop = true },
	["ftn45"] = { category = "dance", dict = "pflookinggood@animations", anim = "pflookinggoodclip", walk = false, loop = true },
	["ftn46"] = { category = "dance", dict = "pfheelclickbreakdown@animations", anim = "pfheelclickbreakdownclip", walk = false, loop = true },
	["ftn47"] = { category = "dance", dict = "pfentranced@animations", anim = "pfentrancedclip", walk = false, loop = true },
	["ftn48"] = { category = "dance", dict = "pffeelitfly@animations", anim = "pffeelitflyclip", walk = false, loop = true },
	["ftn49"] = { category = "dance", dict = "pazeeefortnitestarlit@animations", anim = "pazeeefortnitestarlitclip", walk = false, loop = true },
	["ftn50"] = { category = "dance", dict = "pazeeefortniteboneybounce@animations", anim = "pazeeefortniteboneybounceclip", walk = false, loop = true },
	["ftn51"] = { category = "dance", dict = "pazeeefortniteevilplan@animations", anim = "pazeeefortniteevilplanclip", walk = false, loop = true },
	["ftn52"] = { category = "dance", dict = "pazeeefortnitedancindomino@animations", anim = "pazeeefortnitedancindominoclip", walk = false, loop = true },
	["ftn53"] = { category = "dance", dict = "pazeeefortnitepointandstrut@animations", anim = "pazeeefortnitepointandstrutclip", walk = false, loop = true },
	["ftn54"] = { category = "dance", dict = "pazeeefortnitethedancelaroi@animations", anim = "pazeeefortnitethedancelaroiclip", walk = false, loop = true },
	["ftn55"] = { category = "dance", dict = "pazeeefortnitecopines@animations", anim = "pazeeefortnitecopinesclip", walk = false, loop = true },
	["ftn56"] = { category = "dance", dict = "pazeeefortnitemikubeam@animations", anim = "pazeeefortnitemikubeamclip", walk = false, loop = true },
	["ftn57"] = { category = "dance", dict = "pazeeefortniteitstrue@animations", anim = "pazeeefortniteitstrueclip", walk = false, loop = true },
	["ftn58"] = { category = "dance", dict = "pazeeefortniteimout@animations", anim = "pazeeefortniteimoutclip", walk = false, loop = true },
	["ftn59"] = { category = "dance", dict = "pazeeefortnitescenario@animations", anim = "pazeeefortnitescenarioclip", walk = false, loop = true },
	["ftn60"] = { category = "dance", dict = "pazeeefortnitejabbaswitchway@animations", anim = "pazeeefortnitejabbaswitchwayclip", walk = false, loop = true },
	["ftn61"] = { category = "dance", dict = "pazeeefortnitegomufasa@animations", anim = "pazeeefortnitegomufasaclip", walk = false, loop = true },
	["ftn62"] = { category = "dance", dict = "pazeeefortnitegomufasamove@animations", anim = "pazeeefortnitegomufasamoveclip", walk = false, loop = true },
	["ftn63"] = { category = "dance", dict = "pazeeefortniteeverybodylovesme@animations", anim = "pazeeefortniteeverybodylovesmeclip", walk = false, loop = true },
	["ftn64"] = { category = "dance", dict = "pazeeefortnitegetgriddy@animations", anim = "pazeeefortnitegetgriddyclip", walk = false, loop = true },
	["ftn65"] = { category = "dance", dict = "pazeeefortnitelofiheadbang@animations", anim = "pazeeefortnitelofiheadbangclip", walk = false, loop = true },
	["ftn66"] = { category = "dance", dict = "pazeeefortniterebellious@animations", anim = "pazeeefortniterebelliousclip", walk = false, loop = true },
	["ftn67"] = { category = "dance", dict = "pazeeefortnitebackon74@animations", anim = "pazeeefortnitebackon74clip", walk = false, loop = true },
	["ftn68"] = { category = "dance", dict = "pazeeefortnitebackon74move@animations", anim = "pazeeefortnitebackon74moveclip", walk = false, loop = true },
	["ftn69"] = { category = "dance", dict = "pazeeefortnitebackon74move@animations", anim = "pazeeefortnitebackon74moveclip", walk = false, loop = true },
	["ftn70"] = { category = "dance", dict = "pazeee@fortnite@apt@animations", anim = "pazeee@fortnite@apt@clip", walk = false, loop = true },
	["ftn71"] = { category = "dance", dict = "pazeee@fortnite@roar@animations", anim = "pazeee@fortnite@roar@clip", walk = false, loop = true },
	["ftn72"] = { category = "dance", dict = "pazeee@fortnite@firework@animations", anim = "pazeee@fortnite@firework@clip", walk = false, loop = true },
	["ftn73"] = { category = "dance", dict = "pazeee@fortnite@humble@animations", anim = "pazeee@fortnite@humble@clip", walk = false, loop = true },
	["ftn74"] = { category = "dance", dict = "pazeee@fortnite@360@animations", anim = "pazeee@fortnite@360@clip", walk = false, loop = true },
	["ftn75"] = { category = "dance", dict = "pazeee@fortnite@chasemedown@animations", anim = "pazeee@fortnite@chasemedown@clip", walk = false, loop = true },
	["ftn76"] = { category = "dance", dict = "pazeee@fortnite@smitten@animations", anim = "pazeee@fortnite@smitten@clip", walk = false, loop = true },
	["ftn77"] = { category = "dance", dict = "pazeee@fortnite@itsavibe@animations", anim = "pazeee@fortnite@itsavibe@clip", walk = false, loop = true },
	["ftn78"] = { category = "dance", dict = "pazeee@fortnite@popularvibe@animations", anim = "pazeee@fortnite@popularvibe@clip", walk = false, loop = true },
	["ftn79"] = { category = "dance", dict = "pazeee@fortnite@socialclimber@animations", anim = "pazeee@fortnite@socialclimber@clip", walk = false, loop = true },
	["ftn80"] = { category = "dance", dict = "pazeee@fortnite@cupidsarrow@animations", anim = "pazeee@fortnite@cupidsarrow@clip", walk = false, loop = true },
	["ftn81"] = { category = "dance", dict = "pazeee@fortnite@boysaliar@animations", anim = "pazeee@fortnite@boysaliar@clip", walk = false, loop = true },
	["ftn82"] = { category = "dance", dict = "pazeee@fortnite@bizcochito@animations", anim = "pazeee@fortnite@bizcochito@clip", walk = false, loop = true },
	["ftn83"] = { category = "dance", dict = "pazeee@fortnite@celebrateme@animations", anim = "pazeee@fortnite@celebrateme@clip", walk = false, loop = true },
	["ftn84"] = { category = "dance", dict = "pazeee@fortnite@goated@animations", anim = "pazeee@fortnite@goated@clip", walk = false, loop = true },
	["ftn85"] = { category = "dance", dict = "pazeee@fortnite@nightout@animations", anim = "pazeee@fortnite@nightout@clip", walk = false, loop = true },
	["ftn86"] = { category = "dance", dict = "pazeee@fortnite@runitdown@animations", anim = "pazeee@fortnite@runitdown@clip", walk = false, loop = true },
	["ftn87"] = { category = "dance", dict = "pazeee@fortnite@withoutyou@animations", anim = "pazeee@fortnite@withoutyou@clip", walk = false, loop = true },
	["ftn88"] = { category = "dance", dict = "pazeee@fortnite@blahblahblah@animations", anim = "pazeee@fortnite@blahblahblah@clip", walk = false, loop = true },
	["ftn89"] = { category = "dance", dict = "pazeee@fortnite@letsgetitstarted@animations", anim = "pazeee@fortnite@letsgetitstarted@clip", walk = false, loop = true },
	["ftn90"] = { category = "dance", dict = "pazeee@fortnite@bet@animations", anim = "pazeee@fortnite@bet@clip", walk = false, loop = true },
	["ftn91"] = { category = "dance", dict = "pazeee@fortnite@ratatata@animations", anim = "pazeee@fortnite@ratatata@clip", walk = false, loop = true },
	["ftn92"] = { category = "dance", dict = "pazeee@fortnite@taste@animations", anim = "pazeee@fortnite@taste@clip", walk = false, loop = true },
	["ftn93"] = { category = "dance", dict = "pazeee@fortnite@pleasepleaseplease@animations", anim = "pazeee@fortnite@pleasepleaseplease@clip", walk = false, loop = true },
	["ftn94"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@outwest@animations", anim = "pazeee@fournite@outwest@clip" },
	["ftn95"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@rollie@animations", anim = "pazeee@fournite@rollie@clip" },
	["ftn96"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@thesquabble@animations", anim = "pazeee@fournite@thesquabble@clip" },
	["ftn97"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@billybounce@animations", anim = "pazeee@fournite@billybounce@clip" },
	["ftn98"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@maximumbounce@animations", anim = "pazeee@fournite@maximumbounce@clip" },
	["ftn99"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@stuck@animations", anim = "pazeee@fournite@stuck@clip" },
	["ftn100"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@socks@animations", anim = "pazeee@fournite@socks@clip" },
	["ftn101"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@pullup@animations", anim = "pazeee@fournite@pullup@clip" },
	["ftn102"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@chickenwingit@animations", anim = "pazeee@fournite@chickenwingit@clip" },
	["ftn103"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@savage@animations", anim = "pazeee@fournite@savage@clip" },
	["ftn104"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@imdiamond@animations", anim = "pazeee@fournite@imdiamond@clip" },
	["ftn105"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@itsdynamite@animations", anim = "pazeee@fournite@itsdynamite@clip" },
	["ftn106"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@toosieslide@animations", anim = "pazeee@fournite@toosieslide@clip" },
	["ftn107"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@therenegade@animations", anim = "pazeee@fournite@therenegade@clip" },
	["ftn108"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@dontstartnow@animations", anim = "pazeee@fournite@dontstartnow@clip" },
	["ftn109"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@ambitious@animations", anim = "pazeee@fournite@ambitious@clip" },
	["ftn110"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@lunarparty@animations", anim = "pazeee@fournite@lunarparty@clip" },
	["ftn111"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@hitit@animations", anim = "pazeee@fournite@hitit@clip" },
	["ftn112"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@nocure@animations", anim = "pazeee@fournite@nocure@clip" },
	["ftn113"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@clickclickflash@animations", anim = "pazeee@fournite@clickclickflash@clip" },
	["ftn114"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@wannaseeme@animations", anim = "pazeee@fournite@wannaseeme@clip" },
	["ftn115"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@headbanger@animations", anim = "pazeee@fournite@headbanger@clip" },
	["ftn116"] = { category = "dance", walk = false, loop = true, prop = "v_ilev_fos_mic", mao = 28422, pos1 = 0.13, pos2 = -0.14, pos3 = -0.24, pos4 = -70.0, pos5 = 15.0, pos6 = 0.0, dict = "pazeee@fournite@rage@animations", anim = "pazeee@fournite@rage@clip" },
	["ftn117"] = { category = "dance", walk = false, loop = true, dict = "pazeee@fournite@bigdawgs@animations", anim = "pazeee@fournite@bigdawgs@clip" },
	["ftn118"] = { category = "dance", walk = false, loop = true, flag = 47, dict = "pazeee@fournite@bigdawgsmove@animations", anim = "pazeee@fournite@bigdawgsmove@clip" },
	["ftn119"] = { category = "dance", walk = false, loop = true, flag = 47, dict = "pazeee@fournite@bigdawgsmove@animations", anim = "pazeee@fournite@bigdawgsmove@clip" },
	["ftn120"] = { category = "dance", dict = "pazeee@4nite@nomoney@animations", anim = "pazeee@4nite@nomoney@clip", walk = false, loop = true },
	["ftn121"] = { category = "dance", dict = "pazeee@4nite@thelargest@animations", anim = "pazeee@4nite@thelargest@clip", walk = false, loop = true },
	["ftn122"] = { category = "dance", dict = "pazeee@4nite@jtcoming@animations", anim = "pazeee@4nite@jtcoming@clip", walk = false, loop = true },
	["ftn123"] = { category = "dance", dict = "pazeee@4nite@smeeze@animations", anim = "pazeee@4nite@smeeze@clip", walk = false, loop = true },
	["ftn124"] = { category = "dance", dict = "pazeee@4nite@touch@animations", anim = "pazeee@4nite@touch@clip", walk = false, loop = true },
	["ftn125"] = { category = "dance", dict = "pazeee@4nite@whiplash@animations", anim = "pazeee@4nite@whiplash@clip", walk = false, loop = true },
	["ftn126"] = { category = "dance", dict = "pazeee@4nite@likejennie@animations", anim = "pazeee@4nite@likejennie@clip", walk = false, loop = true },
	["ftn127"] = { category = "dance", dict = "pazeee@4nite@tiktok@animations", anim = "pazeee@4nite@tiktok@clip", walk = false, loop = true },
	["ftn128"] = { category = "dance", dict = "pazeee@4nite@allaboutthatbass@animations", anim = "pazeee@4nite@allaboutthatbass@clip", walk = false, loop = true },
	["ftn129"] = { category = "dance", dict = "pazeee@4nite@dare@animations", anim = "pazeee@4nite@dare@clip", walk = false, loop = true },
	["ftn130"] = { category = "dance", dict = "pazeee@4nite@song2@animations", anim = "pazeee@4nite@song2@clip", walk = false, loop = true },
	["ftn131"] = { category = "dance", dict = "pazeee@4nite@lookatme@animations", anim = "pazeee@4nite@lookatme@clip", walk = false, loop = true },
	["ftn132"] = { category = "dance", dict = "pazeee@4nite@thespark@animations", anim = "pazeee@4nite@thespark@clip", walk = false, loop = true },
	["ftn133"] = { category = "dance", dict = "pazeee@4nite@bedcherm@animations", anim = "pazeee@4nite@bedcherm@clip", walk = false, loop = true },
	["ftn134"] = { category = "dance", dict = "pazeee@4nite@image@animations", anim = "pazeee@4nite@image@clip", walk = false, loop = true },
	["ftn135"] = { category = "dance", dict = "pazeee@4nite@dreamykeys@animations", anim = "pazeee@4nite@dreamykeys@clip", walk = false, loop = true },
	["ftn136"] = { category = "dance", dict = "pazeee@4nite@minglegamedance@animations", anim = "pazeee@4nite@minglegamedance@clip", walk = false, loop = true },
	["ftn137"] = { category = "dance", dict = "pazeee@4nite@oblivion@animations", anim = "pazeee@4nite@oblivion@clip", walk = false, loop = true },
	["ftn138"] = { category = "dance", dict = "pazeee@4nite@takeonme@animations", anim = "pazeee@4nite@takeonme@clip", walk = false, loop = true },
	["ftn139"] = { category = "dance", dict = "pazeee@4nite@wakemeup@animations", anim = "pazeee@4nite@wakemeup@clip", walk = false, loop = true },
	["ftn140"] = { category = "dance", dict = "pazeee@4nite@sidestep@animations", anim = "pazeee@4nite@sidestep@clip", walk = false, loop = true },
	["ftn141"] = { category = "dance", dict = "pazeee@4nite@childlikethings@animations", anim = "pazeee@4nite@childlikethings@clip", walk = false, loop = true },
	["ftn142"] = { category = "dance", dict = "pazeee@4nite@swingmyway@animations", anim = "pazeee@4nite@swingmyway@clip", walk = false, loop = true },
	["ftn143"] = { category = "dance", dict = "pazeee@4nite@two@animations", anim = "pazeee@4nite@two@clip", walk = false, loop = true },
	["ftn144"] = { category = "dance", dict = "pazeee@4nite@thetylildance@animations", anim = "pazeee@4nite@thetylildance@clip", walk = false, loop = true },

	-------------------------------
	-- TIKTOK
	-------------------------------

	["tiktok1"] = { category = "dance", dict = "1@animation", anim = "clip", walk = false, loop = true },
	["tiktok2"] = { category = "dance", dict = "2@animation", anim = "clip", walk = false, loop = true },
	["tiktok3"] = { category = "dance", dict = "3@animation", anim = "clip", walk = false, loop = true },
	["tiktok4"] = { category = "dance", dict = "4@animation", anim = "clip", walk = false, loop = true },
	["tiktok5"] = { category = "dance", dict = "5@animation", anim = "clip", walk = false, loop = true },
	["tiktok6"] = { category = "dance", dict = "6@animation", anim = "clip", walk = false, loop = true },
	["tiktok7"] = { category = "dance", dict = "7@animation", anim = "clip", walk = false, loop = true },
	["tiktok8"] = { category = "dance", dict = "8@animation", anim = "clip", walk = false, loop = true },
	["tiktok9"] = { category = "dance", dict = "9@animation", anim = "clip", walk = false, loop = true },
	["tiktok10"] = { category = "dance", dict = "10@animation", anim = "clip", walk = false, loop = true },

	-------------------------------
	-- CASAL
	-------------------------------

	["casal1"] = { category = "shared", dict = "couple06_m@gengaranimation", anim = "couple06_m_clip", walk = false, loop = true, target_emote = "casal2" },
	["casal2"] = { category = "shared", dict = "couple06_f@gengaranimation", anim = "couple06_f_clip", walk = false, loop = true, target_emote = "casal1",
		offset = {
			x = 1.45,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["casal3"] = { category = "shared", dict = "nsfw2_m@vanessssi", anim = "nsfw2_m_clip", walk = false, loop = true, target_emote = "casal4" },
	["casal4"] = { category = "shared", dict = "nsfw2_f@vanessssi", anim = "nsfw2_f_clip", walk = false, loop = true, target_emote = "casal3",
		offset = {
			x = 0.0,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["casal5"] = { category = "shared", dict = "nsfw1_m@vanessssi", anim = "nsfw1_m_clip", walk = false, loop = true, target_emote = "casal6" },
	["casal6"] = { category = "shared", dict = "nsfw1_f@vanessssi", anim = "nsfw1_f_clip", walk = false, loop = true, target_emote = "casal5",
		offset = {
			x = 0.0,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},
	
	-------------------------------
	-- CARREGAR CRIANÇAS
	-------------------------------


	["carregarcrianca1"] = { category = "shared", dict = "anim@sports@ballgame@handball@", anim = "ball_idle", target_emote = "carregarcrianca1_child", loop = true, walk = true },
	["carregarcrianca1_child"] = { category = "shared", dict = "amb@prop_human_seat_chair@male@elbows_on_knees@idle_a", anim = "idle_a", target_emote = "carregarcrianca1", loop = true, walk = false, hide = true,
		attach = { bone = 60309, xPos = -0.10, yPos = -0.49, zPos = -0.496, xRot = 134.0, yRot = 10.0, zRot = 0.0 }
	},

	["carregarcrianca2"] = { category = "shared", target_emote = "carregarcrianca2_child", loop = true, walk = true },
	["carregarcrianca2_child"] = { category = "shared", dict = "veh@boat@speed@fps@base", anim = "sit_idle", target_emote = "carregarcrianca2", loop = true, walk = false, hide = true,
		attach = { bone = 31086, xPos = 0.45, yPos = -0.35, zPos = 0.0, xRot = -10.0, yRot = 90.0, zRot = 0.0 }
	},

	["carregarcrianca3"] = { category = "shared", dict = "anim@arena@celeb@flat@paired@no_props@", anim = "piggyback_c_player_a", target_emote = "carregarcrianca3_child", loop = true, walk = true },
	["carregarcrianca3_child"] = { category = "shared", dict = "anim@arena@celeb@flat@paired@no_props@", anim = "piggyback_c_player_b", target_emote = "carregarcrianca3", loop = true, walk = false, hide = true,
		attach = { bone = 0, xPos = 0.0, yPos = 0.0, zPos = 1.1, xRot = 0.0, yRot = 0.0, zRot = 0.0 }
	},
	
	-------------------------------
	-- PAZEEE
	-------------------------------

	["arrogante"] = { category = "normal", dict = "pazeee@arroganta@animations", anim = "pazeee@arroganta@clip", andar = false, loop = true },

	-------------------------------
	-- EXPRESSOES
	-------------------------------

	["normal"] = {
		category = "expression", 
		anim = "default"
	},
	["mira"] = {
		category = "expression", 
		anim = "mood_aiming_1"
	},
	["bravo"] = {
		category = "expression", 
		anim = "mood_angry_1"
	},
	["queimando"] = {
		category = "expression", 
		anim = "burning_1"
	},
	["chorando"] = {
		category = "expression", 
		anim = "console_wasnt_fun_end_loop_floyd_facial"
	},
	["morto"] = {
		category = "expression", 
		anim = "dead_1"
	},
	["bêbado"] = {
		category = "expression", 
		anim = "mood_drunk_1"
	},
	["burro"] = {
		category = "expression", 
		anim = "pose_injured_1"
	},
	["eletrocutado"] = {
		category = "expression", 
		anim = "electrocuted_1"
	},
	["animado"] = {
		category = "expression", 
		anim = "mood_excited_1"
	},
	["frustrado"] = {
		category = "expression", 
		anim = "mood_frustrated_1"
	},
	["mal-humorado"] = {
		category = "expression", 
		anim = "effort_1"
	},
	["mal-humorado2"] = {
		category = "expression", 
		anim = "mood_drivefast_1"
	},
	["mal-humorado3"] = {
		category = "expression", 
		anim = "pose_angry_1"
	},
	["feliz"] = {
		category = "expression", 
		anim = "mood_happy_1"
	},
	["ferido"] = {
		category = "expression", 
		anim = "mood_injured_1"
	},
	["jovial"] = {
		category = "expression", 
		anim = "mood_dancing_low_1"
	},
	["jovial2"] = {
		category = "expression", 
		anim = "mood_dancing_low_2"
	},
	["respirandoboca"] = {
		category = "expression", 
		anim = "smoking_hold_1"
	},
	["respirandoboca2"] = {
		category = "expression", 
		anim = "smoking_inhale_1"
	},
	["nuncapisca"] = {
		category = "expression", 
		anim = "pose_normal_1"
	},
	["umolho"] = {
		category = "expression", 
		anim = "pose_aiming_1"	
	},
	["trama"] = {
		category = "expression", 
		anim = "mood_dancing_high_2"
	},
	["chocado"] = {
		category = "expression", 
		anim = "shocked_1"
	},
	["chocado2"] = {
		category = "expression", 
		anim = "shocked_2"
	},
	["dormindo"] = {
		category = "expression", 
		anim = "mood_sleeping_1"
	},
	["dormindo2"] = {
		category = "expression", 
		anim = "dead_1"
	},
	["dormindo3"] = {
		category = "expression", 
		anim = "dead_2"
	},
	["satisfeito"] = {
		category = "expression", 
		anim = "mood_smug_1"
	},
	["especulativo"] = {
		category = "expression", 
		anim = "mood_aiming_1"
	},
	["estressado"] = {
		category = "expression", 
		anim = "mood_stressed_1"
	},
	["amuado"] = {
		category = "expression", 
		anim = "mood_sulk_1"
	},
	["estranho"] = {
		category = "expression", 
		anim = "effort_2"
	},
	["estranho2"] = {
		category = "expression", 
		anim = "effort_3"
	},
	["estranho3"] = {
		category = "expression", 
		anim = "melee_effort_1"
	},

	-------------------------------
	-- ANIMACOES DE SEXO (OCULTOS)
	-------------------------------

	["carbj"] = { category = "shared", target_emote = "carbj2", dict = "oddjobs@towing", anim = "m_blow_job_loop", walk = true, loop = true, cars = true, hide = true },
	["carbj2"] = { category = "shared", target_emote = "carbj", dict = "oddjobs@towing", anim = "f_blow_job_loop", walk = false, loop = true, cars = true, hide = true },

	["carsx"] = { category = "shared", target_emote = "carsx2", walk = false, loop = true, cars = true, hide = true },
	["carsx2"] = { category = "shared", dict = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", target_emote = "carsx", walk = false, loop = true, cars = true, hide = true },

	["bq"] = { category = "shared", dict = "misscarsteal2pimpsex", anim = "pimpsex_punter", target_emote = "bq2", loop = true, walk = false, hide = true },

	["bq2"] = { category = "shared", dict = "misscarsteal2pimpsex", anim = "pimpsex_hooker", target_emote = "bq", loop = true, walk = false, hide = true,
		offset = {
			x = 0.0,
			y = 0.6,
			z = 0.0,
		}
	},

	["sx"] = { category = "shared", dict = "rcmpaparazzo_2", anim = "shag_loop_a", target_emote = "sx2", walk = false, loop = true, hide = true },
	
	["sx2"] = { category = "shared", dict = "rcmpaparazzo_2", anim = "shag_loop_poppy", target_emote = "sx", walk = false, loop = true, hide = true,
		offset = {
			x = -0.1,
			y = 0.35,
			z = 0.0,
			h = 0.0
		}
	},
	
	["sx3"] = { category = "normal", category = "normal", dict = "timetable@trevor@skull_loving_bear", anim = "skull_loving_bear", walk = false, loop = true, hide = true },

	["cowgirl"] = { category = "shared", dict = "genesismods@ert1", anim = "cowgirlm", target_emote = "cowgirl2", walk = false, loop = true, hide = true },
	["cowgirl2"] = { category = "shared", dict = "genesismods@ert2", anim = "cowgirlf", target_emote = "cowgirl", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = 0.0,
			z = 0.0,
			h = 0.0
		}
	},

	["doggy"] = { category = "shared", dict = "genesismods@ert3", anim = "doggystylem", target_emote = "doggy2", walk = false, loop = true, hide = true },
	["doggy2"] = { category = "shared", dict = "genesismods@ert4", anim = "doggystylef", target_emote = "doggy", walk = false, loop = true, hide = true,
		offset = {
			x = 0.31,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["doggy_b"] = { category = "shared", dict = "genesismods@ert5", anim = "doggystyle2m", target_emote = "doggy_b2", walk = false, loop = true, hide = true },
	["doggy_b2"] = { category = "shared", dict = "genesismods@ert6", anim = "doggystyle2f", target_emote = "doggy_b", walk = false, loop = true, hide = true,
		offset = {
			x = 0.41,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["missionary"] = { category = "shared", dict = "genesismods@ert7", anim = "missionarym", target_emote = "missionary_f", walk = false, loop = true, hide = true },
	["missionary_f"] = { category = "shared", dict = "genesismods@ert8", anim = "missionaryf", target_emote = "missionary", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["missionary2"] = { category = "shared", dict = "genesismods@ert9", anim = "missionary2m", target_emote = "missionary2_f", walk = false, loop = true, hide = true },
	["missionary2_f"] = { category = "shared", dict = "genesismods@ert10", anim = "missionary2f", target_emote = "missionary2", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["spooning"] = { category = "shared", dict = "genesismods@ert11", anim = "spooningm", target_emote = "spooning2", walk = false, loop = true, hide = true },
	["spooning2"] = { category = "shared", dict = "genesismods@ert12", anim = "spooningf", target_emote = "spooning", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = 0.2,
			z = 0.0,
			h = 0.0,
		}
	},

	["standing"] = { category = "shared", dict = "genesismods@ert13", anim = "standingm", target_emote = "standing2", walk = false, loop = true, hide = true },
	["standing2"] = { category = "shared", dict = "genesismods@ert14", anim = "standingf", target_emote = "standing", walk = false, loop = true, hide = true,
		offset = {
			x = 0.35,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["standingcowgirl"] = { category = "shared", dict = "genesismods@ert15", anim = "standingcowgirlm", target_emote = "standingcowgirl2", walk = false, loop = true, hide = true },
	["standingcowgirl2"] = { category = "shared", dict = "genesismods@ert16", anim = "standingcowgirlf", target_emote = "standingcowgirl", walk = false, loop = true, hide = true,
		offset = {
			x = 0.15,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["meianove"] = { category = "shared", dict = "genesismods@ert17", anim = "69m", target_emote = "meianove_2", walk = false, loop = true, hide = true },
	["meianove_2"] = { category = "shared", dict = "genesismods@ert18", anim = "69f", target_emote = "meianove", walk = false, loop = true, hide = true,
		offset = {
			x = -0.6,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["hardcore"] = { category = "shared", dict = "genesismods@ert9", anim = "missionary2m", target_emote = "hardcore_f", walk = false, loop = true, hide = true },
	["hardcore_f"] = { category = "shared", dict = "genesismods@ert10", anim = "missionary2f", target_emote = "hardcore", walk = false, loop = true, hide = true,
		offset = {
			x = 0.7,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["blowjob"] = { category = "shared", dict = "genesismods@ert19", anim = "blowjobm", target_emote = "blowjob2", walk = false, loop = true, hide = true },
	["blowjob2"] = { category = "shared", dict = "genesismods@ert20", anim = "blowjobf", target_emote = "blowjob", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = -0.53,
			z = 0.0,
			h = 0.0,
		}
	},

	["deepthroat"] = { category = "shared", dict = "genesismods@ert21", anim = "deepthroatm", target_emote = "deepthroat2", walk = false, loop = true, hide = true },
	["deepthroat2"] = { category = "shared", dict = "genesismods@ert22", anim = "deepthroatf", target_emote = "deepthroat", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = -0.53,
			z = 0.0,
			h = 0.0,
		}
	},

	["licking"] = { category = "shared", dict = "genesismods@ert23", anim = "lickingm", target_emote = "licking2", walk = false, loop = true, hide = true },
	["licking2"] = { category = "shared", dict = "genesismods@ert24", anim = "lickingf", target_emote = "licking", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = -0.7,
			z = 0.0,
			h = 0.0,
		}
	},

	["licking3"] = { category = "shared", dict = "genesismods@ert23", anim = "lickingm", target_emote = "licking4", walk = false, loop = true, hide = true },
	["licking4"] = { category = "shared", dict = "anim3@seimen" , anim = "sexpose3_clip", target_emote = "licking3", walk = false, loop = true, hide = true,
		offset = {
			x = 0.0,
			y = -0.8,
			z = 0.0,
			h = 0.0,
		}
	},


	["licking5"] = { category = "shared", dict = "genesismods@ert23", anim = "lickingm", target_emote = "licking6", walk = false, loop = true, hide = true },
	["licking6"] = { category = "shared", dict = "slave@mchmnk" , anim = "slave_clip", target_emote = "licking5" , andar = false , loop = true , hide = true,
		offset = {
			x = 0.0,
			y = 0.6,
			z = 0.0,
			h = 0.0,
		} 
	},

	["licking7"] = { category = "shared", dict = "slave@mchmnk", anim = "slave_clip", target_emote = "licking8", walk = false, loop = true, hide = true },
	["licking8"] = { category = "shared", dict = "genesismods@ert18" , anim = "69f", target_emote = "licking7" , andar = false , loop = true , hide = true,
		offset = {
			x = 0.0,
			y = -0.7,
			z = 0.0,
			h = -90.0,
		} 
	},

	["meianove2"] = { category = "shared", dict = "slave@mchmnk", anim = "slave_clip", target_emote = "meianove2f", walk = false, loop = true, hide = true },
	["meianove2f"] = { category = "shared", dict = "genesismods@ert18" , anim = "69f", target_emote = "meianove2" , andar = false , loop = true , hide = true,
		offset = {
			x = 0.0,
			y = -0.6,
			z = 0.0,
			h = 90.0,
		} 
	},

	["sxfoto1"] = { category = "normal", dict = "anim3@seimen" , anim = "sexpose3_clip" , andar = false , loop = true , hide = true },
	["sxfoto2"] = { category = "normal", dict = "anim4@seimen" , anim = "sexpose4_clip" , andar = false , loop = true , hide = true },
	["sxfoto3"] = { category = "normal", dict = "anim5@seimen" , anim = "sexpose5_clip" , andar = false , loop = true , hide = true },
	["sxfoto4"] = { category = "normal", dict = "anim6@seimen" , anim = "sexpose6_clip" , andar = false , loop = true , hide = true },
	["sxfoto5"] = { category = "normal", dict = "anim7@seimen" , anim = "sexpose7_clip" , andar = false , loop = true , hide = true },
	["sxfoto6"] = { category = "normal", dict = "anim8@seimen" , anim = "sexpose8_clip" , andar = false , loop = true , hide = true },
	["sxfoto7"] = { category = "normal", dict = "anim9@seimen" , anim = "sexpose9_clip" , andar = false , loop = true , hide = true },
	["sxfoto8"] = { category = "normal", dict = "anim10@seimen" , anim = "sexpose10_clip" , andar = false , loop = true , hide = true },
	["sxfoto9"] = { category = "normal", dict = "anim11@seimen" , anim = "sexpose11_clip" , andar = false , loop = true , hide = true },
	["sxfoto10"] = { category = "normal", dict = "anim12@seimen" , anim = "sexpose12_clip" , andar = false , loop = true , hide = true },
	["sxfoto11"] = { category = "normal", dict = "anim13@seimen" , anim = "sexpose13_clip" , andar = false , loop = true , hide = true },
	["sxfoto12"] = { category = "normal", dict = "anim14@seimen" , anim = "sexpose14_clip" , andar = false , loop = true , hide = true },
	["sxfoto13"] = { category = "normal", dict = "anim15@seimen" , anim = "sexpose15_clip" , andar = false , loop = true , hide = true },
	["sxfoto14"] = { category = "normal", dict = "anim16@seimen" , anim = "sexpose16_clip" , andar = false , loop = true , hide = true },
	["sxfoto15"] = { category = "normal", dict = "anim17@seimen" , anim = "sexpose17_clip" , andar = false , loop = true , hide = true },
	["sxfoto16"] = { category = "normal", dict = "anim18@seimen" , anim = "sexpose18_clip" , andar = false , loop = true , hide = true },
	["sxfoto17"] = { category = "normal", dict = "anim19@seimen" , anim = "sexpose19_clip" , andar = false , loop = true , hide = true },
	["sxfoto18"] = { category = "normal", dict = "anim20@seimen" , anim = "sexpose20_clip" , andar = false , loop = true , hide = true },
	["sxfoto19"] = { category = "normal", dict = "anim21@seimen" , anim = "sexpose21_clip" , andar = false , loop = true , hide = true },
	["sxfoto20"] = { category = "normal", dict = "anim22@seimen" , anim = "sexpose22_clip" , andar = false , loop = true , hide = true },
	["sxfoto21"] = { category = "normal", dict = "anim23@seimen" , anim = "sexpose23_clip" , andar = false , loop = true , hide = true },
	["sxfoto22"] = { category = "normal", dict = "genesismods@ert24", anim = "lickingf", andar = false, loop = true, hide = true, },
	["sxfoto23"] = { category = "normal", dict = "zc@sexy01" , anim = "zc_sexy" , andar = false , loop = true, hide = true },
	["sxfoto24"] = { category = "normal", dict = "zc@sexy05" , anim = "sexy05" , andar = false , loop = true, hide = true },

	["sxfoto25"] = { category = "shared", dict = "littlespoon@sensual001" , anim = "sensual001" , target_emote = "sxfoto26" , andar = false , loop = true, hide = true },
	["sxfoto26"] = { category = "shared", dict = "littlespoon@sensual002" , anim = "sensual002" , target_emote = "sxfoto25" , andar = false , loop = true, hide = true,
		offset = {
			x = 0.2,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["sxfoto27"] = { category = "shared", dict = "littlespoon@sensual003" , anim = "sensual003" , target_emote = "sxfoto28" , andar = false , loop = true, hide = true },
	["sxfoto28"] = { category = "shared", dict = "littlespoon@sensual004" , anim = "sensual004" , target_emote = "sxfoto27" , andar = false , loop = true, hide = true,
		offset = {
			x = 0.0,
			y = 1.0,
			z = 0.0,
			h = 180.0,
		}
    },

	["sxfoto29"] = { category = "shared", dict = "littlespoon@sensual005" , anim = "sensual005" , target_emote = "sxfoto30" , andar = false , loop = true, hide = true },
	["sxfoto30"] = { category = "shared", dict = "littlespoon@sensual006" , anim = "sensual006" , target_emote = "sxfoto29" , andar = false , loop = true, hide = true,
		offset = {
			x = 0.0,
			y = -1.05,
			z = 0.0,
			h = 180.0,
		} 
    },

	["sxfoto31"] = { category = "shared", dict = "littlespoon@sensual007" , anim = "sensual007" , target_emote = "sxfoto32" , andar = false , loop = true, hide = true },
	["sxfoto32"] = { category = "shared", dict = "littlespoon@sensual008" , anim = "sensual008" , target_emote = "sxfoto31" , andar = false , loop = true, hide = true, 
		offset = {
			x = 0.13,
			y = 0.7,
			z = 0.0,
			h = 0.0,
		}
	},

	["sxfoto33"] = { category = "shared", dict = "littlespoon@sensual009" , anim = "sensual009" , target_emote = "sxfoto34" , andar = false , loop = true, hide = true },
	["sxfoto34"] = { category = "shared", dict = "littlespoon@sensual010" , anim = "sensual010" , target_emote = "sxfoto33" , andar = false , loop = true, hide = true,
		offset = {
			x = 0.0,
			y = 1.3,
			z = 0.0,
			h = 0.0,
		}
	},


	
	["sexyass"] = { category = "normal", dict = "sexyass@d3vilros3" , anim = "sexyass_clip" , andar = false , loop = true, hide = true },
	["sexyfeet"] = { category = "normal", dict = "sexyfeet@d3vilros3" , anim = "sexyfeet_clip" , andar = false , loop = true, hide = true },

	["slavepose"] = { category = "normal", dict = "slavepose@anim" , anim = "slavepose_clip" , andar = false , loop = true , hide = true },
	["slavepose2"] = { category = "normal", dict = "slave@mchmnk" , anim = "slave_clip" , andar = false , loop = true , hide = true },

	["sitsexy"] = { category = "normal", dict = "sitsexylean@queensisters" , anim = "sitsexy_clip" , andar = false , loop = true , hide = true },
	["fuckfinger"] = { category = "normal", dict = "fuckfingerlips@queensisters" , anim = "fuckfingerlips_clip" , andar = false , loop = true },

	["waitingfordaddy"] = { category = "normal", dict = "waitingfordaddy@mchmnk" , anim = "waitingfordaddy_clip" , andar = false , loop = true , hide = true },
	["mistress"] = { category = "normal", dict = "mistress@mchmnk" , anim = "mistress_clip" , andar = false , loop = true, hide = true },
	
	["coupleero01fr"] = { category = "shared", dict = "coupleero01fr@mchmnk" , anim = "coupleero01fr_clip",target_emote = "coupleero01tw" , andar = false , loop = true , hide = true },
	["coupleero01tw"] = { category = "shared", dict = "coupleero01tw@mchmnk" , anim = "coupleero01tw_clip",target_emote = "coupleero01fr" , andar = false , loop = true , hide = true,
		offset = {
			x = 0.0,
			y = 0.2,
			z = 0.0,
			h = 180.0,
		} 
	},

	["facesitting"] = { category = "shared", dict = "mistress@mchmnk" , anim = "mistress_clip", target_emote = "facesitting2" , andar = false , loop = true , hide = true },
	["facesitting2"] = { category = "shared", dict 	= "slave@mchmnk" , anim = "slave_clip", target_emote = "facesitting" , andar = false , loop = true , hide = true,
		offset = {
			x = 0.0,
			y = 0.6,
			z = 0.0,
			h = 0.0,
		} 
	},

	["facesitting3"] = { category = "shared", dict = "slavepose@anim" , anim = "slavepose_clip", target_emote = "facesitting4" , andar = false , loop = true , hide = true },
	["facesitting4"] = { category = "shared", dict = "slave@mchmnk" , anim = "slave_clip", target_emote = "facesitting3" , andar = false , loop = true , hide = true,
		offset = {
			x = 0.0,
			y = 0.6,
			z = 0.0,
			h = 0.0,
		} 
	},

	["stripper"] = { category = "normal", dict = "stripper1@anim" , anim = "stripper1_clip" , andar = false , loop = true, hide = true },
	["stripper2"] = { category = "normal", dict = "strip2@anim" , anim = "strip2_clip" , andar = false , loop = true , hide = true },

	["poledance"] = { category = "normal", dict = "poledancer@anim" , anim = "poledancer_clip" , andar = false , loop = true, hide = true  },
	["poledance2"] = { category = "normal", dict = "poledancer2@anim" , anim = "poledancer2_clip" , andar = false , loop = true, hide = true  },
	["poledance3"] = { category = "normal", dict = "poledancer3@anim" , anim = "poledancer3_clip" , andar = false , loop = true, hide = true  },

	["foot"] = { category = "normal", dict = "1foot@anim" , anim = "1foot_clip" , andar = false , loop = true, hide = true  },
	["footwork"] = { category = "normal", dict = "custom@footwork" , anim = "footwork" , andar = false , loop = true },
	
	["femalepose"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_001" , andar = false , loop = true },
	["femalepose2"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_002" , andar = false , loop = true },
	["femalepose3"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_003" , andar = false , loop = true },
	["femalepose4"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_004" , andar = false , loop = true },
	["femalepose5"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_005" , andar = false , loop = true },
	["femalepose6"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_006" , andar = false , loop = true },
	["femalepose7"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_007" , andar = false , loop = true },
	["femalepose8"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_008" , andar = false , loop = true },
	["femalepose9"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_009" , andar = false , loop = true },
	["femalepose10"] = { category = "normal", dict = "frabi@femalepose@solo@specialphoto" , anim = "pose_specialphoto_010" , andar = false , loop = true },

	["femalepose11"] = { category = "normal", dict = "standing1@blackqueen" , anim = "standing1_clip" , andar = false , loop = true },

	["beijar"] = { category = "shared", dict = "genesismods_kissme@kissfemale" , anim = "kissfemale" , andar = false , loop = true , target_emote = "beijar_m" },
	["beijar_m"] = { category = "shared", dict = "genesismods_kissme@kissmale" , anim = "kissmale" , andar = false , loop = true ,hide = true, target_emote = "beijar",
		offset = {
			x = 0.0,
			y = 0.15,
			z = 0.0,
			h = 0.0,
		}
	},

	["beijar2"] = { category = "shared", dict = "genesismods_kissme@kissfemale2" , anim = "kissfemale2" , andar = false , loop = true , target_emote = "beijar2_m" },
	["beijar2_m"] = { category = "shared", dict = "genesismods_kissme@kissmale2" , anim = "kissmale2" , andar = false , loop = true , hide = true, target_emote = "beijar2",
		offset = {
			x = 0.0,
			y = 0.3,
			z = 0.0,
			h = 0.0,
		}
	},

	["beijar3"] = { category = "shared", dict = "genesismods_kissme@kissfemale3" , anim = "kissfemale3" , andar = false , loop = true , target_emote = "beijar3_m" },
	["beijar3_m"] = { category = "shared", dict = "genesismods_kissme@kissmale3" , anim = "kissmale3" , andar = false , loop = true , hide = true, target_emote = "beijar3",
		offset = {
			x = 0.0,
			y = 0.32,
			z = 0.0,
			h = 180.0,
		}
	},

	["beijar4"] = { category = "shared", dict = "genesismods_kissme@kissfemale4" , anim = "kissfemale4" , andar = false , loop = true , target_emote = "beijar4_m" },
	["beijar4_m"] = { category = "shared", dict = "genesismods_kissme@kissmale4" , anim = "kissmale4" , andar = false , loop = true , hide = true, target_emote = "beijar4",
		offset = {
			x = 0.02,
			y = 0.27,
			z = 0.0,
			h = 180.0,
		}
	},

	["beijar5"] = { category = "shared", dict = "genesismods_kissme@kissfemale5" , anim = "kissfemale5" , andar = false , loop = true , target_emote = "beijar5_m" },
	["beijar5_m"] = { category = "shared", dict = "genesismods_kissme@kissmale5" , anim = "kissmale5" , andar = false , loop = true , hide = true, target_emote = "beijar5",
		offset = {
			x = 0.0,
			y = 0.28,
			z = 0.0,
			h = 180.0,
		}
	},

	["beijar6"] = { category = "shared", dict = "genesismods_kissme@kissfemale6" , anim = "kissfemale6" , andar = false , loop = true , target_emote = "beijar6_m" },
	["beijar6_m"] = { category = "shared", dict = "genesismods_kissme@kissmale6" , anim = "kissmale6" , andar = false , loop = true , hide = true, target_emote = "beijar6",
		offset = {
			x = 0.0,
			y = 0.42,
			z = 0.0,
			h = 180.0,
		}
	},

	["beijar7"] = { category = "shared", dict = "genesismods_kissme@kissfemale7" , anim = "kissfemale7" , andar = false , loop = true , target_emote = "beijar7_m" },
	["beijar7_m"] = { category = "shared", dict = "genesismods_kissme@kissmale7" , anim = "kissmale7" , andar = false , loop = true , hide = true, target_emote = "beijar7",
		offset = {
			x = 0.0,
			y = -0.27,
			z = 0.0,
			h = 0.0,
		}
	},

	["beijar8"] = { category = "shared", dict = "genesismods_kissme@kissfemale8" , anim = "kissfemale8" , andar = false , loop = true , target_emote = "beijar8_m" },
	["beijar8_m"] = { category = "shared", dict = "genesismods_kissme@kissmale8" , anim = "kissmale8" , andar = false , loop = true , hide = true, target_emote = "beijar8",
		offset = {
			x = -0.57,
			y = 0.02,
			z = 0.0,
			h = 0.0,
		}
	},

	["beijar9"] = { category = "shared", dict = "genesismods_kissme@kissfemale9" , anim = "kissfemale9" , andar = false , loop = true , target_emote = "beijar9_m" },
	["beijar9_m"] = { category = "shared", dict = "genesismods_kissme@kissmale9" , anim = "kissmale9" , andar = false , loop = true , hide = true, target_emote = "beijar9",
		offset = {
			x = 0.32,
			y = 0.0,
			z = 0.0,
			h = 0.0,
		}
	},

	["beijar10"] = { category = "shared", dict = "genesismods_kissme@kissfemale10" , anim = "kissfemale10" , andar = false , loop = true , target_emote = "beijar10_m" },
	["beijar10_m"] = { category = "shared", dict = "genesismods_kissme@kissmale10" , anim = "kissmale10" , andar = false , loop = true , hide = true, target_emote = "beijar10",
		offset = {
			x = 0.4,
			y = -0.01,
			z = 0.0,
			h = 0.0,
		}
	},

	["sexy_girls_bed_pose1"] = { category = "normal", dict = "sexy_girls_bed_pose1@darks37" , anim = "sexy_girls_bed_pose1_clip" , andar = false , loop = true, hide = true },


	["sxfoto35"] = { category = "normal", dict = "murda@heart", anim = "heart", andar = false, loop = true, hide = true },
	["sxfoto36"] = { category = "normal", dict = "murda@mirrorselfiehot", anim = "mirrorselfiehot", andar = false, loop = true, hide = true },
	["sxfoto37"] = { category = "normal", dict = "murda@femalelookback", anim = "femalelookback", andar = false, loop = true, hide = true },
	["sxfoto38"] = { category = "normal", dict = "murda@femalefloor", anim = "femalefloor", andar = false, loop = true, hide = true, offset = { z = -0.50 } },
	["sxfoto39"] = { category = "normal", dict = "murda@thickbody", anim = "thickbody", andar = false, loop = true, hide = true, offset = { z = -0.84 } },
	["sxfoto40"] = { category = "normal", dict = "murda@regularbody", anim = "regularbody", andar = false, loop = true, hide = true, offset = { z = -0.84 } },
	["sxfoto41"] = { category = "normal", dict = "murda@thickbody", anim = "thickbody", andar = false, loop = true, hide = true },
	["sxfoto42"] = { category = "normal", dict = "murda@wakandaforever", anim = "wakandaforever", andar = false, loop = true, hide = true },
	["sxfoto43"] = { category = "normal", dict = "murda@wakandaforever2", anim = "wakandaforever2", andar = false, loop = true, hide = true },

	["poledance"] = { category = "normal", dict = "mini@strip_club@pole_dance@pole_dance1", anim = "pd_dance_01", andar = false, loop = true },
	["poledance2"] = { category = "normal", dict = "mini@strip_club@pole_dance@pole_dance2", anim = "pd_dance_02", andar = false, loop = true },
	["poledance3"] = { category = "normal", dict = "mini@strip_club@pole_dance@pole_dance3", anim = "pd_dance_03", andar = false, loop = true },

	["poledance4"] = { category = "normal", dict = "frabi@femalepose@solo@firstpoledance", anim = "pose_poledance_001", andar = false, loop = true },
	["poledance5"] = { category = "normal", dict = "frabi@femalepose@solo@firstpoledance", anim = "pose_poledance_002", andar = false, loop = true },
	["poledance6"] = { category = "normal", dict = "frabi@femalepose@solo@firstpoledance", anim = "pose_poledance_003", andar = false, loop = true },
	["poledance7"] = { category = "normal", dict = "frabi@femalepose@solo@firstpoledance", anim = "pose_poledance_004", andar = false, loop = true },
	["poledance8"] = { category = "normal", dict = "frabi@femalepose@solo@firstpoledance", anim = "pose_poledance_005", andar = false, loop = true },

	["cuddlepartner1"] = { category = "shared", dict = "cuddlepartner1@pawuk", anim = "cuddlepartner1_clip", andar = false, loop = true, target_emote = "cuddlepartner2" },
	["cuddlepartner2"] = { category = "shared", dict = "cuddlepartner2@pawuk", anim = "cuddlepartner2_clip", andar = false, loop = true, target_emote = "cuddlepartner1", offset = { x = 0, y = 0.4, z = 0 } },
}

