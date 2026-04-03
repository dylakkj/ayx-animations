Config = {
	MenuKey = "F11",
	Theme = "black",

	SharedEmoteStartTime = 10,
	MaxDistanceForSharedEmotes = 3.0,
	DistanceForAllEmotes = 5.0,

	AllowedInCars = false,

	AnimBlendIn = 2.0,    -- Velocidade de entrada na animação
	AnimBlendOut = -2.0,   -- Velocidade de saída da animação

	Notify = function(msg, title, tipo)
		TriggerEvent("Notify", title or "Animação", msg, tipo or "info", 5000)
	end,

	ShortcutKey = 21,
	CancelKey = "F6",
	AnimationAcceptKey = "Y",
	AnimationRefuseKey = "N",

	AnimListBlocked = {
		["PedsCanUse"] = {
			"mp_m_freemode_01",
			"mp_f_freemode_01"
		},
		["AnimList"] = (function()
			local blockedAnims = {
				"tragar",
				"fumar",
				"beber",
				"sexo",
				"dildo"
			}
			
			-- Adicionar e dildo (1 a 5)
			for i = 1, 5 do
				table.insert(blockedAnims, "dildo" .. i)
			end

			-- Adicionar e fumar (1 a 7)
			for i = 1, 7 do
				table.insert(blockedAnims, "fumar" .. i)
			end

			-- Adicionar e beber (1 a 10)
			for i = 1, 10 do
				table.insert(blockedAnims, "beber" .. i)
			end
			
			-- Adicionar e sexo (1 a 7)
			for i = 1, 7 do
				table.insert(blockedAnims, "sexo" .. i)
			end
			
			return blockedAnims
		end)()
	},

	ExclusiveAnims = {
		["sx"] = true,
		["sx2"] = true,
		["sx3"] = true,
		["carbj"] = true,
		["carbj2"] = true,
		["sx6"] = true,
		["sx7"] = true,
		["bq"] = true,
		["bq2"] = true,
		["sxfoto1"] = true,
		["sxfoto2"] = true,
		["sxfoto3"] = true,
		["sxfoto4"] = true,
		["sxfoto5"] = true,
		["sxfoto6"] = true,
		["sxfoto7"] = true,
		["sxfoto8"] = true,
		["sxfoto9"] = true,
		["sxfoto10"] = true,
		["sxfoto11"] = true,
		["sxfoto12"] = true,
		["sxfoto13"] = true,
		["sxfoto14"] = true,
		["sxfoto15"] = true,
		["sxfoto16"] = true,
		["sxfoto21"] = true,
		["sxfoto22"] = true,
		["sxfoto23"] = true,
		["sxfoto24"] = true,
		["sxfoto25"] = true,
		["sxfoto26"] = true,
		["sxfoto27"] = true,
		["sxfoto28"] = true,
		["sxfoto29"] = true,
		["sxfoto30"] = true,
		["sxfoto31"] = true,
		["sxfoto32"] = true,
		["sxfoto33"] = true,
		["sxfoto34"] = true,
		["sxfoto35"] = true,
		["sxfoto36"] = true,
		["sxfoto37"] = true,
		["sxfoto38"] = true,
		["sxfoto39"] = true,
		["sxfoto40"] = true,
		["sxfoto41"] = true,
		["sxfoto42"] = true,
		["sxfoto43"] = true,

		["doggy"] = true,
		["doggy2"] = true,
		["doggy_b"] = true,
		["doggy_b2"] = true,
		["standing"] = true,
		["standing2"] = true,
		["missionary"] = true,
		["missionary_f"] = true,
		["missionary2"] = true,
		["missionary2_f"] = true,
		["standingcowgirl"] = true,
		["standingcowgirl2"] = true,
		["meianove"] = true,
		["meianove_2"] = true,
		["blowjob"] = true,
		["blowjob2"] = true,
		["deepthroat"] = true,
		["deepthroat2"] = true,
		["licking"] = true,
		["licking2"] = true,
		["licking3"] = true,
		["licking4"] = true,
		["licking5"] = true,
		["licking6"] = true,
		["licking7"] = true,
		["licking8"] = true,
		["spooning"] = true,
		["spooning2"] = true,
		["hardcore"] = true,
		["hardcore_f"] = true,
		["sexy_girls_bed_pose1"] = true,
		["facesitting"] = true,
		["facesitting2"] = true,
		["facesitting3"] = true,
		["facesitting4"] = true,
		["coupleero01fr"] = true,
		["coupleero01tw"] = true,
		["mistress"] = true,
		["waitingfordaddy"] = true,
		["sitsexy"] = true,
		["meianove2"] = true,
		["meianove2f"] = true,
		["sexyass"] = true,
		["sexyfeet"] = true,

		["stripper"] = true,
		["stripper2"] = true,

		["poledance"] = true,
		["poledance2"] = true,
		["poledance3"] = true,
		
	},

	AuthorizedPassports = {
		[128] = true,
		[313] = true,
		[315] = true,
		[1022] = true,
		[5940] = true
	}
}

Config.Locale = 'br'
Config.Controls = {}
Config.Controls.Accept = {'Y', 246}
Config.Controls.Refuse = {'U', 303}
