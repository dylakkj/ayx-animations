-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("animacoes")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENT LICENSE CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
local IsLicenseValid = false
local AnimLookup = {}

local function UpdateAnimLookup()
	AnimLookup = {}
	for k, v in pairs(AnimTable) do
		AnimLookup[k:lower()] = v
	end
end

function IsClientLicensed()
	return IsLicenseValid
end

CreateThread(function()
	while not IsLicenseValid do
		Wait(3000)
		local status = vSERVER.CheckLicenseStatus()
		if status then
			IsLicenseValid = true
			break
		end
	end
end)	

-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("emotes")
AddEventHandler("emotes",function(Name)
	if not IsClientLicensed() then return end
	local Ped = PlayerPedId()
	if vSERVER.CheckBucket() then return end
	if Config.ExclusiveAnims and Config.ExclusiveAnims[Name] then return end
	
	if AnimTable[Name] and not IsPedSwimming(Ped) and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Cancel"] and not LocalPlayer["state"]["Handcuff"] then
		local pedModel = GetEntityModel(Ped)
		local pedName = GetHashKey(pedModel)
		for _, blockedAnim in ipairs(Config.AnimListBlocked["AnimList"]) do
			if Name == blockedAnim then
				local canUse = false
				for _, allowedPed in ipairs(Config.AnimListBlocked["PedsCanUse"]) do
					if GetHashKey(allowedPed) == pedModel then
						canUse = true
						break
					end
				end
				if not canUse then
					TriggerEvent("Notify","Animação","Você não pode usar esta animação.","vermelho",5000)
					return
				end
				break
			end
		end
		
		if IsPedArmed(Ped,7) and not AnimTable[Name].weapon then return end
		if AnimTable[Name].hide then return end
		if not IsPedInAnyVehicle(Ped) and not AnimTable[Name]["cars"] then
			if AnimTable[Name]["altura"] and not AnimTable[Name]["anim"] then
				vRP.CreateObjects("","",AnimTable[Name]["prop"],AnimTable[Name]["flag"],AnimTable[Name]["mao"],AnimTable[Name]["altura"],AnimTable[Name]["pos1"],AnimTable[Name]["pos2"],AnimTable[Name]["pos3"],AnimTable[Name]["pos4"],AnimTable[Name]["pos5"])
			elseif AnimTable[Name]["altura"] and AnimTable[Name]["anim"] then
				vRP.CreateObjects(AnimTable[Name]["dict"],AnimTable[Name]["anim"],AnimTable[Name]["prop"],AnimTable[Name]["flag"],AnimTable[Name]["mao"],AnimTable[Name]["altura"],AnimTable[Name]["pos1"],AnimTable[Name]["pos2"],AnimTable[Name]["pos3"],AnimTable[Name]["pos4"],AnimTable[Name]["pos5"])
			elseif AnimTable[Name]["prop"] then
				vRP.CreateObjects(AnimTable[Name]["dict"],AnimTable[Name]["anim"],AnimTable[Name]["prop"],AnimTable[Name]["flag"],AnimTable[Name]["mao"])
			elseif AnimTable[Name]["dict"] then
				vRP.playAnim(AnimTable[Name]["walk"],{AnimTable[Name]["dict"],AnimTable[Name]["anim"]},AnimTable[Name]["loop"])
			else
				vRP.playAnim(false,{ task = AnimTable[Name]["anim"] },false)
			end
		else
			if IsPedInAnyVehicle(Ped) and AnimTable[Name]["cars"] then
				vRP.playAnim(AnimTable[Name]["walk"],{AnimTable[Name]["dict"],AnimTable[Name]["anim"]},AnimTable[Name]["loop"])
			end
		end
	end
end)


function GetClosestPlayer()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local players = GetActivePlayers()
	local closest, closestDist = nil, 0

	for _, player in ipairs(players) do
		local targetPed = GetPlayerPed(player)
		if targetPed ~= ped then
			local targetCoords = GetEntityCoords(targetPed)
			local distance = #(coords - targetCoords)

			if closest == nil or distance < closestDist then
				closest, closestDist = GetPlayerServerId(player), distance
			end
		end
	end

	return closest, closestDist
end

function LoadAnimDict(dict)
	local timer = GetGameTimer()

	while GetGameTimer() - timer < 2500 and not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(0)
	end
end

function LoadAnimSet(name)
	local timer = GetGameTimer()

	while GetGameTimer() - timer < 2500 and not HasAnimSetLoaded(name) do
		RequestAnimSet(name)
		Wait(0)
	end
end

function LoadModel(model)
	local timer = GetGameTimer()

	while GetGameTimer() - timer < 2500 and not HasModelLoaded(model) do
		RequestModel(model)
		Wait(0)
	end
end

function CancelEmote(ped)
	ped = ped or PlayerPedId()
	if not IsPedReloading(ped) then
		GlobalEmoteSequence = GlobalEmoteSequence + 1
		if IsInPreview then
			IsInPreview = false
		end

		SendNUIMessage({
			action = 'setAccepted',
			val = false
		})
		
		if ClonedPed then
			DeleteEntity(ClonedPed)
		end

		if CurrentAnimation then
			ped = ped or PlayerPedId()
			if not IsPedReloading(ped) then
				DetachEntity(ped, true, true)
				SetEntityCollision(ped, true, true)
				FreezeEntityPosition(ped, false)

				if CurrentAnimation.dict == "Scenario" then
					ClearPedTasksImmediately(ped)
					ClearAreaOfObjects(GetEntityCoords(ped), 3.0, 0)
				else
					PtfxStop()
					ClearPedTasks(ped)
					DestroyAllProps()
				end

				if CurrentAnimation.category == "shared" then
					TriggerServerEvent("ayxlz_emotes:cancelShared")
				end

				if CurrentSharedTestPed and DoesEntityExist(CurrentSharedTestPed) then
					DetachEntity(CurrentSharedTestPed, true, true)
					ClearPedTasksImmediately(CurrentSharedTestPed)
					CurrentSharedTestPed = nil
				end

				CurrentAnimation = nil
			end
		end
	end
end

function AddPropToPed(ped, model, bone, off1, off2, off3, rot1, rot2, rot3, dict, anim, flag)
	PtfxStop()
	ClearPedTasks(ped)
	DestroyAllProps()
	LoadModel(model)
	local x, y, z = table.unpack(GetEntityCoords(ped))
	local prop = CreateObject(GetHashKey(model), x, y, z + 0.2, ped == PlayerPedId(), true, true)

	local boneIndex = GetPedBoneIndex(ped, bone)

	off1, off2, off3 = off1 or 0.0, off2 or 0.0, off3 or 0.0
	rot1, rot2, rot3 = rot1 or 0.0, rot2 or 0.0, rot3 or 0.0

	AttachEntityToEntity(
		prop,
		ped,
		boneIndex,
		vector3(off1, off2, off3),
		vector3(rot1, rot2, rot3),
		true, true, false, false, 2, true, 0
	)
	if ped == PlayerPedId() then
		table.insert(PlayerProps, prop)
	else
		table.insert(FakeProps, prop)
		SetEntityAlpha(prop, 150, true)
	end
end

function DestroyAllProps()
	for _, prop in pairs(PlayerProps) do
		DeleteEntity(prop)
	end

	PlayerProps = {}
end

function PtfxStart()
	local ptfx = CurrentAnimation.ptfx
	local ptfxAt = ptfx.no_prop and PlayerPedId() or PlayerProps[1]
	local p1, p2, p3, p4, p5, p6 = table.unpack(ptfx.placement)

	UseParticleFxAssetNextCall(ptfx.asset)

	local particle = StartNetworkedParticleFxLoopedOnEntityBone(ptfx.name, ptfxAt, p1, p2, p3, p4, p5, p6,
		GetEntityBoneIndexByName(ptfx.name, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)

	SetParticleFxLoopedColour(particle, 1.0, 1.0, 1.0)

	table.insert(PlayerParticles, particle)
end

function PtfxStop()
	for _, particle in pairs(PlayerParticles) do
		StopParticleFxLooped(particle, false)
	end

	PlayerParticles = {}
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
FakeProps = {}
IsInPreview = false
ShowPed = false
ClonedPed = nil
CurrentSharedTestPed = nil
GlobalEmoteSequence = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE PREVIEW EMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePreviewEmote(emoteName)
	for k, v in pairs(FakeProps) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end
	
	if IsInPreview then
		IsInPreview = false
		ShowPed = false
		DeleteEntity(ClonedPed)
		ClonedPed = nil
	end

	Wait(100)

	if not IsInPreview then
		local emote = GetEmoteOnTable(emoteName)

		if not emote or emote.category == "expression" or emote.category == "walk" then return end

		IsInPreview = true

		CreateThread(function()
			local coords = GetEntityCoords(PlayerPedId())
			ClonedPed = CreatePed(26, GetEntityModel(PlayerPedId()), coords.x, coords.y, coords.z, 0.0, false, false)

			if not DoesEntityExist(ClonedPed) then
				return
			end

			ClonePedToTarget(PlayerPedId(), ClonedPed)

			SetEntityCollision(ClonedPed, false, false)
			SetEntityInvincible(ClonedPed, true)
			SetEntityLocallyVisible(ClonedPed)
			SetEntityCanBeDamaged(ClonedPed, false)
			SetBlockingOfNonTemporaryEvents(ClonedPed, true)
			SetEntityAlpha(ClonedPed, 254)

			NetworkSetEntityInvisibleToNetwork(ClonedPed, true)

			ShowPed = true

			local positionBuffer = {}
			local bufferSize = 5

			ExecuteEmote(emoteName, ClonedPed, false, false)

			while ShowPed do
				local screenX, screenY = 0.65135417461395, 0.7787036895752
				local depth = 3.5

				if zoom then
					screenX, screenY = 0.6, 1.9
					depth = 2.8
				end

				local world, normal = GetWorldCoordFromScreenCoord(screenX, screenY)
				local target = world + normal * depth
				local camRot = GetGameplayCamRot(2)

				table.insert(positionBuffer, target)
				if #positionBuffer > bufferSize then table.remove(positionBuffer, 1) end

				local averagedTarget = vector3(0, 0, 0)
				for _, pos in ipairs(positionBuffer) do
					averagedTarget = averagedTarget + pos
				end
				averagedTarget = averagedTarget / #positionBuffer

				SetEntityCoords(ClonedPed, averagedTarget.x, averagedTarget.y, averagedTarget.z, false, false, false, true)
				SetEntityHeading(ClonedPed, camRot.z + 170.0)
				SetEntityRotation(ClonedPed, camRot.x * -1, 0, camRot.z + 170.0, false, false)

				Wait(10)
			end
		end)

	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local AttTable = false
AnimationList = AnimTable
CurrentAnimation = nil
PlayerProps = {}
PlayerParticles = {}
SecondPropEmote = false
local TestAnimMode = false
local TestPeds = {}
local TestPedsNetIds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX ANIMATION TABLE FOR UI
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	if not AttTable then
		local NewTable = {}
		for NameEmote, Table in pairs(AnimationList) do
			if not AnimationList[NameEmote].hide then
				AnimationList[NameEmote].name = NameEmote
				table.insert(NewTable, AnimationList[NameEmote])
			end
		end

		table.sort(NewTable, function(a, b)
			local function splitName(name)
				local prefix, num = string.match(name, "^(.-)(%d+)$")
				if prefix then
					return prefix, tonumber(num)
				else
					return name, nil
				end
			end

			local aPrefix, aNum = splitName(a.name)
			local bPrefix, bNum = splitName(b.name)

			if aPrefix == bPrefix then
				if aNum and bNum then
					return aNum < bNum
				elseif aNum then
					return true
				elseif bNum then
					return false
				else
					return a.name < b.name
				end
			else
				return aPrefix < bPrefix
			end
		end)

		AnimationList = NewTable
		AttTable = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET EMOTE ON TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetEmoteOnTable(emoteName)
	if not emoteName then return nil end
	local lowerName = emoteName:lower()
	if AnimLookup[lowerName] then
		AnimLookup[lowerName].name = lowerName
		return AnimLookup[lowerName]
	end
	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTE MENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("animacoes",function()
	if not IsClientLicensed() then return end
	local Ped = PlayerPedId()
	if LocalPlayer["state"]["Active"] and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped)  and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
		MenuStatus()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTE THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RegisterKeyMapping("animacoes", "Abrir menu de animação", "keyboard", Config.MenuKey)
	while true do
		local TimeDistance = 1000

		if CurrentAnimation and not IsPauseMenuActive() then
			TimeDistance = 250
			local Ped = PlayerPedId()

			if IsPedShooting(Ped) then
				CancelEmote()
			end

			if IsControlPressed(0, 47) and CurrentAnimation.ptfx then
				PtfxStart()
				Wait(500)
				PtfxStop()
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXECUTE EMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
function ExecuteEmote(EmoteName, Ped, Target, toggle, bypassExclusive, seq)
	if not IsClientLicensed() then return end
	
	if vSERVER.CheckBucket() then return end
	
	if not bypassExclusive and Config.ExclusiveAnims and Config.ExclusiveAnims[EmoteName] then 
		TriggerEvent("Notify","Animação","Você não possui acesso a esta animação exclusiva.","vermelho",5000)
		return 
	end
	
	CreateThread(function()
		local mySeq = seq
		if not mySeq then
			GlobalEmoteSequence = GlobalEmoteSequence + 1
			mySeq = GlobalEmoteSequence
		end

		local SelectedEmote = GetEmoteOnTable(EmoteName)
		if not SelectedEmote then 
			TriggerEvent("Notify","Animação","Animação não encontrada.","vermelho",5000)
			return 
		end

		if toggle then 
			MenuStatus(false) 
		end
		
		local Ped = Ped or PlayerPedId()

		if Ped == PlayerPedId() and not Target then
			if CurrentSharedTestPed and DoesEntityExist(CurrentSharedTestPed) then
				DetachEntity(CurrentSharedTestPed, true, true)
				ClearPedTasksImmediately(CurrentSharedTestPed)
				CurrentSharedTestPed = nil
			end
		end

		local pedModel = GetEntityModel(Ped)
		
		for _, blockedAnim in ipairs(Config.AnimListBlocked["AnimList"]) do
			if EmoteName == blockedAnim then
				local canUse = false
				for _, allowedPed in ipairs(Config.AnimListBlocked["PedsCanUse"]) do
					if GetHashKey(allowedPed) == pedModel then
						canUse = true
						break
					end
				end
				
				if not canUse then
					TriggerEvent("Notify","Animação","Você não pode usar esta animação.","vermelho",5000)
					return
				end
				break
			end
		end

		if SelectedEmote.category == "expression" then

			if SelectedEmote.anim == "default" then
				ClearFacialIdleAnimOverride(Ped)
				return
			end
			SetFacialIdleAnimOverride(Ped, SelectedEmote.anim)

		elseif SelectedEmote.category == "walk" then

			if SelectedEmote.anim == "default" then
				ResetPedMovementClipset(Ped, 0.2)
				return
			end
			LoadAnimSet(SelectedEmote.anim)
			if GlobalEmoteSequence ~= mySeq then
				RemoveAnimSet(SelectedEmote.anim)
				return
			end
			SetPedMovementClipset(Ped, SelectedEmote.anim, 0.2)
			RemoveAnimSet(SelectedEmote.anim)

		elseif SelectedEmote.category == "shared" and not Target then
			local ClosestTestPed = nil
			if #TestPeds > 0 then
				local lastTestPed = TestPeds[#TestPeds]
				if DoesEntityExist(lastTestPed) and #(GetEntityCoords(Ped) - GetEntityCoords(lastTestPed)) <= 5.0 then
					ClosestTestPed = lastTestPed
				end
			end
			
			if ClosestTestPed then
				if Ped == PlayerPedId() then
					CurrentSharedTestPed = ClosestTestPed
				end
				if SelectedEmote.dict and SelectedEmote.dict ~= "Scenario" then LoadAnimDict(SelectedEmote.dict) end
				local _te = GetEmoteOnTable(SelectedEmote.target_emote)
				if _te and _te.dict and _te.dict ~= "Scenario" then LoadAnimDict(_te.dict) end
				ExecuteEmote(EmoteName, Ped, ClosestTestPed, toggle, bypassExclusive, mySeq)
				ExecuteEmote(SelectedEmote.target_emote, ClosestTestPed, Ped, false, bypassExclusive, mySeq)
				return
			elseif TestAnimMode then
				local Coords = GetEntityCoords(Ped)
				local Heading = GetEntityHeading(Ped)
				local ForwardVector = GetEntityForwardVector(Ped)
				local SpawnCoords = vector3(
					Coords.x + ForwardVector.x * 1.0,
					Coords.y + ForwardVector.y * 1.0,
					Coords.z
				)
				
				local newTestPed = CreatePed(26, GetEntityModel(Ped), SpawnCoords.x, SpawnCoords.y, SpawnCoords.z, Heading + 180.0, false, false)
				ClonePedToTarget(Ped, newTestPed)
				SetEntityCoords(newTestPed, SpawnCoords.x, SpawnCoords.y, SpawnCoords.z, false, false, false, false)
				SetEntityHeading(newTestPed, Heading + 180.0)
				SetEntityAsMissionEntity(newTestPed, true, true)
				SetBlockingOfNonTemporaryEvents(newTestPed, true)
				FreezeEntityPosition(newTestPed, true)
				
				local weaponHash = GetSelectedPedWeapon(Ped)
				if weaponHash and weaponHash ~= `WEAPON_UNARMED` then
					GiveWeaponToPed(newTestPed, weaponHash, 255, false, true)
					SetCurrentPedWeapon(newTestPed, weaponHash, true)
				end
				
				table.insert(TestPeds, newTestPed)
				
				if Ped == PlayerPedId() then
					CurrentSharedTestPed = newTestPed
				end

				if SelectedEmote.dict and SelectedEmote.dict ~= "Scenario" then LoadAnimDict(SelectedEmote.dict) end
				local _te2 = GetEmoteOnTable(SelectedEmote.target_emote)
				if _te2 and _te2.dict and _te2.dict ~= "Scenario" then LoadAnimDict(_te2.dict) end
				ExecuteEmote(EmoteName, Ped, newTestPed, toggle, bypassExclusive, mySeq)
				ExecuteEmote(SelectedEmote.target_emote, newTestPed, Ped, false, bypassExclusive, mySeq)
				
				TriggerEvent("Notify","Animação","Modo teste ativo - PED criado.","verde",5000)
				return
			else
				local ClosestPlayer, ClosestDist = GetClosestPlayer()

				if not ClosestPlayer or ClosestDist >= Config.MaxDistanceForSharedEmotes then
					TriggerEvent("Notify","Animação","Nenhuma pessoa proxima a você.","vermelho",5000)
					return
				end

				TriggerEvent("Notify","Animação","Solicitação de animação enviada.","amarelo",5000)
				TriggerServerEvent("ayxlz_emotes:request", ClosestPlayer, EmoteName, SelectedEmote.target_emote, false)
			end
		else
			local InVehicle = IsPedInAnyVehicle(Ped, true)

			if not Config.AllowedInCars and InVehicle and not SelectedEmote.cars then
				return
			end

			if SelectedEmote.dict == "Scenario" then
				TaskStartScenarioInPlace(Ped, SelectedEmote.anim, 0, true)
			else
				local Flag = 0

				if SelectedEmote.loop then
					Flag += 1
				end

				if not InVehicle then
					if SelectedEmote.walk then
						Flag += 48
					end

					if SelectedEmote.stuck then
						Flag += 2
					end
				end

				local AnimDuration = SelectedEmote.duration or -1

				if SelectedEmote.prop then
					if SelectedEmote.prop then
						if SelectedEmote.pos6 then
							AddPropToPed(Ped, SelectedEmote.prop, SelectedEmote.mao, SelectedEmote.pos1, SelectedEmote.pos2, SelectedEmote.pos3, SelectedEmote.pos4, SelectedEmote.pos5, SelectedEmote.pos6)
						else
							AddPropToPed(Ped, SelectedEmote.prop, SelectedEmote.mao, SelectedEmote.altura, SelectedEmote.pos1, SelectedEmote.pos2, SelectedEmote.pos3, SelectedEmote.pos4, SelectedEmote.pos5)
						end
					end
				end

				if Target and Target ~= -1 then
					local TargetEmote = GetEmoteOnTable(SelectedEmote.target_emote)
					local Attach = SelectedEmote.attach
					if Attach then
						local Bone = GetPedBoneIndex(Target, Attach.bone or 0)
						AttachEntityToEntity(Ped, Target, Bone, Attach.xPos or 0.0,
							Attach.yPos or 0.0,
							Attach.zPos or 0.0,
							Attach.xRot or 0.0,
							Attach.yRot or 0.0, 
							Attach.zRot or 0.0, 
							false, false, false, true, 0,
							true
						)
						vSERVER.StateAnim(true,Target)
					else
						local Offset = SelectedEmote.offset

						if Offset then
							local targetObj = GetEmoteOnTable(SelectedEmote.name) or SelectedEmote
							local actualOffset = targetObj.offset or SelectedEmote.offset

							function CalculatePos()
								if not Target or not DoesEntityExist(Target) then return end
								local offX = actualOffset.x or 0.0
								local offY = actualOffset.y or 1.0
								local offZ = actualOffset.z or 0.0
								local offH = GetEntityHeading(Target) + (actualOffset.h or 180.0)

								local Coords = GetOffsetFromEntityInWorldCoords(Target, offX, offY, offZ)

								SetEntityCoordsNoOffset(Ped, Coords.x, Coords.y, Coords.z, false, false, true)
								SetEntityHeading(Ped, offH)
							end

							CalculatePos()

							CreateThread(function()
								while IsInPreview do
									CalculatePos()
									Wait(7)
								end
							end)
						end
					end
				else
					local Offset = SelectedEmote.offset
					if Offset then
						local offX = Offset.x or 0.0
						local offY = Offset.y or 0.0
						local offZ = Offset.z or 0.0
						local offH = GetEntityHeading(Ped) + (Offset.h or 0.0)

						local Coords = GetOffsetFromEntityInWorldCoords(Ped, offX, offY, offZ)
						SetEntityCoordsNoOffset(Ped, Coords.x, Coords.y, Coords.z, false, false, true)
						SetEntityHeading(Ped, offH)
						FreezeEntityPosition(Ped, true)
					end
				end
				
				if SelectedEmote.dict then
					LoadAnimDict(SelectedEmote.dict)
					if GlobalEmoteSequence ~= mySeq then
						RemoveAnimDict(SelectedEmote.dict)
						return
					end
					if InVehicle and SelectedEmote.cars then
						local animDict = SelectedEmote.dict
						local animName = SelectedEmote.anim
						local vehicle = GetVehiclePedIsIn(Ped, false)
						local isDriver = GetPedInVehicleSeat(vehicle, -1) == Ped
						local carFlag = isDriver and 49 or 1 
						TaskPlayAnim(Ped, animDict, animName, Config.AnimBlendIn, Config.AnimBlendOut, -1, carFlag, 0.0, false, false, false)
						CreateThread(function()
							while CurrentAnimation and CurrentAnimation.cars do
								local ped = PlayerPedId()
								if not IsPedInAnyVehicle(ped, true) then
									break
								end
								Wait(100)
							end
						end)
					else
						TaskPlayAnim(Ped, SelectedEmote.dict, SelectedEmote.anim, Config.AnimBlendIn, Config.AnimBlendOut, AnimDuration, Flag, 0.0, false, false, false)
						RemoveAnimDict(SelectedEmote.dict)
					end
				end
			end

			if Ped == PlayerPedId() then
				CurrentAnimation = SelectedEmote
				
				if SelectedEmote.dict and SelectedEmote.dict ~= "Scenario" and SelectedEmote.loop then
					local monitorSeq = mySeq
					local monitorEmoteName = EmoteName
					
					CreateThread(function()
						Wait(1000)
						
						while CurrentAnimation and CurrentAnimation.name == monitorEmoteName and GlobalEmoteSequence == monitorSeq do
							local ped = PlayerPedId()
							
							if not IsEntityPlayingAnim(ped, CurrentAnimation.dict, CurrentAnimation.anim, 3) then
								
								local reapplyFlag = 0
								if CurrentAnimation.loop then reapplyFlag = reapplyFlag + 1 end
								if not IsPedInAnyVehicle(ped, true) then
									if CurrentAnimation.walk then reapplyFlag = reapplyFlag + 48 end
									if CurrentAnimation.stuck then reapplyFlag = reapplyFlag + 2 end
								end
								local reapplyDuration = CurrentAnimation.duration or -1
								
								LoadAnimDict(CurrentAnimation.dict)
								if GlobalEmoteSequence ~= monitorSeq then
									RemoveAnimDict(CurrentAnimation.dict)
									break
								end
								TaskPlayAnim(ped, CurrentAnimation.dict, CurrentAnimation.anim, Config.AnimBlendIn, Config.AnimBlendOut, reapplyDuration, reapplyFlag, 0.0, false, false, false)
								RemoveAnimDict(CurrentAnimation.dict)
								
								if Target and Target ~= -1 and DoesEntityExist(Target) and CurrentAnimation.attach then
									local Att = CurrentAnimation.attach
									local Bone = GetPedBoneIndex(ped, Att.bone or 0)
									AttachEntityToEntity(Target, ped, Bone,
										Att.xPos or 0.0,
										Att.yPos or 0.0,
										Att.zPos or 0.0,
										Att.xRot or 0.0,
										Att.yRot or 0.0,
										Att.zRot or 0.0,
										false, false, false, true, 0,
										true
									)
								end
								
								Wait(500)
							end
							
							Wait(500)
						end
					end)
				end
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOP EMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("StopEmote", function()
	local Ped = PlayerPedId()
	if IsPedReloading(Ped) or IsPedShooting(Ped) then
		return
	end
	if CurrentAnimation then
		if not IsPedReloading(Ped) and not IsPedShooting(Ped) then
			CancelEmote()
		end
	end
end, false)
RegisterKeyMapping("StopEmote", 'Cancel Emote', 'keyboard', Config.CancelKey)
RegisterNetEvent("ayxlz_emotes:cancelEmote", CancelEmote)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local lastRequest
RegisterCommand("accept_emote", function()
	if lastRequest then
		TriggerServerEvent("ayxlz_emotes:response", lastRequest, true)
		lastRequest = nil

		SendNUIMessage({
			action = 'setAccepted',
			val = true
		})
	end
end, false)

RegisterCommand("deny_emote", function()
	if lastRequest then
		TriggerServerEvent("ayxlz_emotes:response", lastRequest, false)
		lastRequest = nil

		SendNUIMessage({
			action = 'showRequest',
			request = {}
		})
	end
end, false)

RegisterKeyMapping("accept_emote", 'Accept Emote Request', 'keyboard', Config.AnimationAcceptKey)
RegisterKeyMapping("deny_emote", 'Deny Emote Request', 'keyboard', Config.AnimationRefuseKey)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:sendRequest")
AddEventHandler("ayxlz_emotes:sendRequest", function(request)
	SendNUIMessage({
		action = 'showRequest',
		request = request
	})

	lastRequest = request

	CreateThread(function()
		local currentRequest = request
		Wait(30000)
		if lastRequest == currentRequest then
			TriggerServerEvent("ayxlz_emotes:response", lastRequest, false)
			lastRequest = nil
			SendNUIMessage({
				action = 'showRequest',
				request = {}
			})
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECLINE REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:declinedRequest")
AddEventHandler("ayxlz_emotes:declinedRequest", function()

	lastRequest = nil
	TriggerEvent("Notify","Animação","Solicitação de animação em dupla <b>recusada</b>!","vermelho",5000)
	SendNUIMessage({
		action = 'showRequest',
		request = {}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST FROM /T COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:requestFromCommand", function(targetServerId, emoteName)
	if not IsClientLicensed() then return end
	local Ped = PlayerPedId()
	if vSERVER.CheckBucket() then return end

	local SelectedEmote = GetEmoteOnTable(emoteName)
	if not SelectedEmote then
		TriggerEvent("Notify","Animação","Animação não encontrada.","vermelho",5000)
		return
	end

	if SelectedEmote.category ~= "shared" then
		-- Se não é shared, executa normalmente
		TriggerServerEvent("ayxlz_emotes:request", targetServerId, emoteName, emoteName, false)
		return
	end

	local targetEmote = SelectedEmote.target_emote or emoteName
	TriggerEvent("Notify","Animação","Solicitação de animação enviada.","amarelo",5000)
	TriggerServerEvent("ayxlz_emotes:request", targetServerId, emoteName, targetEmote, false)
end)
RegisterNetEvent("ayxlz_emotes:commandEmote")
AddEventHandler("ayxlz_emotes:commandEmote", function(emoteName, isFriend, bypassExclusive)
	if not IsClientLicensed() then return end
	if vSERVER.CheckBucket() then return end

	if not bypassExclusive and Config.ExclusiveAnims and Config.ExclusiveAnims[emoteName] then
		TriggerEvent("Notify","Animação","Você não possui acesso a esta animação exclusiva.","vermelho",5000)
		return
	end

	if isFriend then
		local SelectedEmote = GetEmoteOnTable(emoteName)
		if not SelectedEmote then
			TriggerEvent("Notify","Animação","Animação não encontrada.","vermelho",5000)
			return
		end

		local ClosestPlayer, ClosestDist = GetClosestPlayer()
		if not ClosestPlayer or ClosestDist >= Config.MaxDistanceForSharedEmotes then
			TriggerEvent("Notify","Animação","Nenhuma pessoa próxima a você.","vermelho",5000)
			return
		end

		local targetEmote = SelectedEmote.target_emote or emoteName
		TriggerEvent("Notify","Animação","Solicitação de animação enviada.","amarelo",5000)
		TriggerServerEvent("ayxlz_emotes:request", ClosestPlayer, emoteName, targetEmote, false)
	else
		ExecuteEmote(emoteName, nil, nil, false, bypassExclusive)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FORCE COMMAND EMOTE (FROM /Y2)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:forceCommandEmote")
AddEventHandler("ayxlz_emotes:forceCommandEmote", function(emoteName)
	if not IsClientLicensed() then return end
	if vSERVER.CheckBucket() then return end

	local SelectedEmote = GetEmoteOnTable(emoteName)
	if not SelectedEmote then
		TriggerEvent("Notify","Animação","Animação não encontrada.","vermelho",5000)
		return
	end

	if SelectedEmote.category == "shared" then
		local Ped = PlayerPedId()
		local ClosestTestPed = nil
		
		if #TestPeds > 0 then
			local lastTestPed = TestPeds[#TestPeds]
			if DoesEntityExist(lastTestPed) and #(GetEntityCoords(Ped) - GetEntityCoords(lastTestPed)) <= 5.0 then
				ClosestTestPed = lastTestPed
			end
		end

		if ClosestTestPed then
			CurrentSharedTestPed = ClosestTestPed
			if SelectedEmote.dict and SelectedEmote.dict ~= "Scenario" then LoadAnimDict(SelectedEmote.dict) end
			local targetEmoteData = GetEmoteOnTable(SelectedEmote.target_emote)
			if targetEmoteData and targetEmoteData.dict and targetEmoteData.dict ~= "Scenario" then LoadAnimDict(targetEmoteData.dict) end
			ExecuteEmote(emoteName, Ped, ClosestTestPed, false, true)
			ExecuteEmote(SelectedEmote.target_emote, ClosestTestPed, Ped, false, true)
			return
		end

		local ClosestPlayer, ClosestDist = GetClosestPlayer()
		if not ClosestPlayer or ClosestDist >= Config.MaxDistanceForSharedEmotes then
			TriggerEvent("Notify","Animação","Nenhuma pessoa próxima a você.","vermelho",5000)
			return
		end

		local targetEmote = SelectedEmote.target_emote or emoteName
		TriggerServerEvent("ayxlz_emotes:forceSharedEmote", ClosestPlayer, emoteName, targetEmote)
	else
		ExecuteEmote(emoteName, nil, nil, false, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEST ANIM MODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("testanim", function()
	if vSERVER.IsAdmin() then
		TestAnimMode = not TestAnimMode
		
		if TestAnimMode then
			TriggerEvent("Notify","Animação","Modo teste de animações ATIVADO.","verde",5000)
		else
			TriggerEvent("Notify","Animação","Modo teste de animações DESATIVADO.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOAD ANIMATIONS TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("reloadanim", function()
	if vSERVER.IsAdmin() then
		local fileContent = LoadResourceFile(GetCurrentResourceName(), "client-side/custom.lua")
		if fileContent then
			local func, err = load(fileContent)
			if func then
				AnimTable = {} -- Limpa a tabela velha
				func() -- Executa o custom.lua para popular AnimTable novamente
				
				-- Refaz o parse pro UI e pro AnimationList
				local NewTable = {}
				for NameEmote, Table in pairs(AnimTable) do
					if not AnimTable[NameEmote].hide then
						AnimTable[NameEmote].name = NameEmote
						table.insert(NewTable, AnimTable[NameEmote])
					end
				end

				table.sort(NewTable, function(a, b)
					local function splitName(name)
						local prefix, num = string.match(name, "^(.-)(%d+)$")
						if prefix then
							return prefix, tonumber(num)
						else
							return name, nil
						end
					end

					local aPrefix, aNum = splitName(a.name)
					local bPrefix, bNum = splitName(b.name)

					if aPrefix == bPrefix then
						if aNum and bNum then
							return aNum < bNum
						elseif aNum then
							return true
						elseif bNum then
							return false
						else
							return a.name < b.name
						end
					else
						return aPrefix < bPrefix
					end
				end)

				AnimationList = NewTable
				TriggerEvent("Notify", "verde", "Animações (custom.lua) recarregadas com sucesso!", 5000)
			else
				TriggerEvent("Notify", "vermelho", "Erro ao recarregar animações: " .. tostring(err), 5000)
			end
		else
			TriggerEvent("Notify", "vermelho", "Não foi possível encontrar o arquivo custom.lua.", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAY SHARED EMOTE (SINCRONIZADO - com dados de âncora do servidor)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:playSharedEmoteSync")
AddEventHandler("ayxlz_emotes:playSharedEmoteSync", function(syncData)
	if not IsClientLicensed() then return end
	
	local emoteName = syncData.emoteName
	local targetNetId = syncData.targetNetId
	local anchor = syncData.anchor
	local role = syncData.role
	
	local Ped = PlayerPedId()
	local SelectedEmote = GetEmoteOnTable(emoteName)
	
	if not SelectedEmote then
		TriggerEvent("Notify","Animação","Animação não encontrada.","vermelho",5000)
		return
	end
	
	---------------------------------------------------------------------------
	-- VERIFICA SE O JOGADOR ESTÁ EM UM VEÍCULO E A ANIMAÇÃO É DE CARRO
	-- Se sim, pula toda a lógica de posicionamento para não remover do veículo
	---------------------------------------------------------------------------
	local isInVehicle = IsPedInAnyVehicle(Ped, true)
	local targetEmoteForCarsCheck = SelectedEmote.target_emote and GetEmoteOnTable(SelectedEmote.target_emote)
	local isCarAnim = SelectedEmote.cars or (targetEmoteForCarsCheck and targetEmoteForCarsCheck.cars)
	local skipPositioning = isInVehicle and isCarAnim
	
	---------------------------------------------------------------------------
	-- CANCELA animação atual antes de iniciar a nova (evita posição errada)
	-- NOTA: NÃO envia cancelShared ao servidor aqui! O servidor já atualizou
	-- o activeShared com os dados da nova animação antes de enviar este evento.
	-- Enviar cancelShared aqui limparia os dados NOVOS, quebrando o F6.
	---------------------------------------------------------------------------
	if CurrentAnimation then
		local ped = PlayerPedId()
		
		if skipPositioning then
			-- Está em veículo com animação de carro: limpa animação SEM remover do veículo
			PtfxStop()
			ClearPedSecondaryTask(ped)
			DestroyAllProps()
		else
			-- Detach e descongelar
			DetachEntity(ped, true, true)
			SetEntityCollision(ped, true, true)
			FreezeEntityPosition(ped, false)
			
			-- Limpa animação/cenário
			if CurrentAnimation.dict == "Scenario" then
				ClearPedTasksImmediately(ped)
				ClearAreaOfObjects(GetEntityCoords(ped), 3.0, 0)
			else
				PtfxStop()
				ClearPedTasks(ped)
				DestroyAllProps()
			end
		end
		
		-- Limpa ped compartilhado
		if CurrentSharedTestPed and DoesEntityExist(CurrentSharedTestPed) then
			DetachEntity(CurrentSharedTestPed, true, true)
			ClearPedTasksImmediately(CurrentSharedTestPed)
			CurrentSharedTestPed = nil
		end
		
		CurrentAnimation = nil
		GlobalEmoteSequence = GlobalEmoteSequence + 1
		
		-- Pausa para a limpeza completar antes de iniciar a nova
		Wait(200)
	end
	
	---------------------------------------------------------------------------
	-- PRÉ-CARREGA o animation dict ANTES de posicionar (evita delay)
	---------------------------------------------------------------------------
	if SelectedEmote.dict and SelectedEmote.dict ~= "Scenario" then
		LoadAnimDict(SelectedEmote.dict)
	end
	
	-- Também pré-carrega o dict do target_emote se existir (para o outro lado já ter pronto)
	if SelectedEmote.target_emote then
		local targetEmote = GetEmoteOnTable(SelectedEmote.target_emote)
		if targetEmote and targetEmote.dict and targetEmote.dict ~= "Scenario" then
			LoadAnimDict(targetEmote.dict)
		end
	end
	
	if role == "anchor" then
		if not skipPositioning then
			SetEntityCoordsNoOffset(Ped, anchor.x, anchor.y, anchor.z, false, false, false)
			SetEntityHeading(Ped, anchor.h)
			FreezeEntityPosition(Ped, true)
			
			Wait(100)
		end
		
		local targetPed = targetNetId ~= -1 and NetToPed(targetNetId) or -1
		
		if targetPed ~= -1 and DoesEntityExist(targetPed) then
			SetEntityNoCollisionEntity(Ped, targetPed, true)
			SetEntityNoCollisionEntity(targetPed, Ped, true)
		end
		
		ExecuteEmote(emoteName, nil, targetPed, false, true)
		
		local targetEmoteData = SelectedEmote.target_emote and GetEmoteOnTable(SelectedEmote.target_emote)
		local partnerHasOffset = targetEmoteData and targetEmoteData.offset
		
		CreateThread(function()
			Wait(500)
			if not skipPositioning and CurrentAnimation and not CurrentAnimation.offset and not CurrentAnimation.attach and not partnerHasOffset then
				FreezeEntityPosition(Ped, false)
			end
			
			while CurrentAnimation and CurrentAnimation.category == "shared" and targetPed ~= -1 and DoesEntityExist(targetPed) do
				SetEntityNoCollisionEntity(Ped, targetPed, true)
				Wait(500)
			end
			
			if DoesEntityExist(Ped) then
				SetEntityCollision(Ped, true, true)
			end
		end)
		
	elseif role == "synced" then
		Wait(200)
		
		local targetPed = targetNetId ~= -1 and NetToPed(targetNetId) or -1
		
		if targetPed ~= -1 and DoesEntityExist(targetPed) then
			SetEntityNoCollisionEntity(Ped, targetPed, true)
			SetEntityNoCollisionEntity(targetPed, Ped, true)
		end
		
		if not skipPositioning then
			if SelectedEmote.offset and targetPed ~= -1 then
				local Offset = SelectedEmote.offset
				local offX = Offset.x or 0.0
				local offY = Offset.y or 1.0
				local offZ = Offset.z or 0.0
				local offH = anchor.h + (Offset.h or 180.0)
				
				local anchorHeadingRad = math.rad(anchor.h)
				local cosH = math.cos(anchorHeadingRad)
				local sinH = math.sin(anchorHeadingRad)
				
				local worldOffX = anchor.x + (offX * cosH - offY * sinH)
				local worldOffY = anchor.y + (offX * sinH + offY * cosH)
				local worldOffZ = anchor.z + offZ
				
				SetEntityCoordsNoOffset(Ped, worldOffX, worldOffY, worldOffZ, false, false, true)
				SetEntityHeading(Ped, offH)
				FreezeEntityPosition(Ped, true)
				
				Wait(100)
			elseif SelectedEmote.attach and targetPed ~= -1 then
				local anchorHeadingRad = math.rad(anchor.h)
				local nearX = anchor.x + math.cos(anchorHeadingRad) * 0.5
				local nearY = anchor.y + math.sin(anchorHeadingRad) * 0.5
				
				SetEntityCoordsNoOffset(Ped, nearX, nearY, anchor.z, false, false, false)
				Wait(100)
			end
		end
		
		ExecuteEmote(emoteName, nil, targetPed, false, true)
		
		CreateThread(function()
			while CurrentAnimation and CurrentAnimation.category == "shared" and targetPed ~= -1 and DoesEntityExist(targetPed) do
				SetEntityNoCollisionEntity(Ped, targetPed, true)
				Wait(500)
			end
			
			if DoesEntityExist(Ped) then
				SetEntityCollision(Ped, true, true)
			end
		end)
	end
	
	-- Limpa a UI de request
	SendNUIMessage({
		action = 'showRequest',
		request = {}
	})
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAY SHARED EMOTE (LEGADO - fallback para compatibilidade)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:playSharedEmote")
AddEventHandler("ayxlz_emotes:playSharedEmote", function(emoteName, targetPed)

	ExecuteEmote(emoteName, nil, targetPed == -1 and targetPed or NetToPed(targetPed), false, true)

	SendNUIMessage({
		action = 'showRequest',
		request = {}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:notify")
AddEventHandler("ayxlz_emotes:notify", function(msg, desc, type)
	Config.Notify(msg, desc, type)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHORTCUTS SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local keys = { a = 34, b = 29, c = 26, d = 30, e = 49, f = 23, g = 47, h = 74, i = 23, j = 38, k = 311, l = 182, m = 244, n = 249, o = 199, p = 44, q = 38, r = 45, s = 33, t = 245, u = 303, v = 244, w = 32, x = 73, y = 246, z = 20 }
CreateThread(function()
	local sleep = 250

	while true do
		Wait(sleep)
		
		if IsDisabledControlPressed(0, 21) or IsControlPressed(0, 21) then
			sleep = 10

			for key, value in pairs(keys) do
				if IsControlJustPressed(0, value) then
					SendNUIMessage({
						action = 'playSavedEmote',
						key = key
					})

					break
				end
			end
		else
			sleep = 250
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local UILoaded = false
local UIOpen = false
local SavedAnims = {}
local SharedAnimCD = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN/CLOSE MENU
-----------------------------------------------------------------------------------------------------------------------------------------
function MenuStatus(NewStatus)
	if not IsClientLicensed() then return end
	if not UILoaded then 
		return 
	end

	if type(NewStatus) == "boolean" then
		UIOpen = NewStatus
	else
		UIOpen = not UIOpen
	end

	for k, v in pairs(FakeProps) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end

	if ClonedPed or IsInPreview then
		DeleteEntity(ClonedPed)
		IsInPreview = false
		ShowPed = false
		ClonedPed = nil
		FakeProps = {}
	end


	SetNuiFocus(UIOpen, UIOpen)
	SendNUIMessage({ action = "display", status = UIOpen })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN/CLOSE COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emotes", function()
	if not IsClientLicensed() then return end
	MenuStatus()
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB SET SAVED ANIMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("setSavedAnims", function(data, cb)
	SavedAnims = data
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("close", function(_, cb)
	cb("ok")
	MenuStatus(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB LOADED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("loaded", function(_, cb)
	cb("ok")
	UILoaded = true
	UpdateAnimLookup()
	SendNUIMessage({
		action = "init",
		animationList = AnimationList,
		theme = Config.Theme,
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB PLAY EMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("playEmote", function(emoteName, cb)
	cb("ok")
	if not IsClientLicensed() then return end
	ExecuteEmote(emoteName, false, false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB PREVIEW EMOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("previewEmote", function(emoteName, cb)
	cb("ok")
	if not IsClientLicensed() then return end
	CreatePreviewEmote(emoteName)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB GET CLOSE PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("getClosePlayers", function(_, cb)
	local Players = GetActivePlayers()
	local PedCoords = GetEntityCoords(PlayerPedId())
	local Data = {}

	for _, v in pairs(Players) do
		if v ~= PlayerId() then
			if #(PedCoords - GetEntityCoords(GetPlayerPed(v))) < 15.0 then
				local Ped = GetPlayerPed(v)
				local pos = GetEntityCoords(Ped)
				local name = GetPlayerName(v)
	
				table.insert(Data, {
					id = GetPlayerServerId(v),
					name = name,
					pos = pos
				})
			end
		end
	end

	cb(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB SEND INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("sendInvite", function(Data, cb)
	if SharedAnimCD + 1000 > GetGameTimer() then 
		return 
	end

	SharedAnimCD = GetGameTimer()
	TriggerServerEvent("ayxlz_emotes:request", Data.player, Data.emote.name, Data.emote.target_emote, false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CB PLAYER ANIM EVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("playerAnimEveryone", function(Emote, cb)
	if SharedAnimCD + 1000 > GetGameTimer() then 
		return 
	end
	SharedAnimCD = GetGameTimer()

	local players = GetActivePlayers()
	local pedCoords = GetEntityCoords(PlayerPedId())
	local data = {}

	for k, v in pairs(players) do
		if #(pedCoords - GetEntityCoords(GetPlayerPed(v))) <= Config.DistanceForAllEmotes then
			local ped = GetPlayerPed(v)
			local pos = GetEntityCoords(ped)
			local name = GetPlayerName(v)

			table.insert(data, {
				id = GetPlayerServerId(v),
				name = name,
				pos = pos,
				emote = Emote
			})
		end
	end

	local RandomId = math.random(5000, 80000000)

	for k, v in pairs(data) do
		TriggerServerEvent("ayxlz_emotes:request", v, v.emote.name, v.emote.target_emote, true, RandomId)
		Wait(10)
	end

	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN TEST PED CLI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:spawnTestPedCli")
AddEventHandler("ayxlz_emotes:spawnTestPedCli", function()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Heading = GetEntityHeading(Ped)
	local ForwardVector = GetEntityForwardVector(Ped)
	local resX = Coords.x + (ForwardVector.x * 1.5)
	local resY = Coords.y + (ForwardVector.y * 1.5)
	local resZ = Coords.z -- Mantém a altura exata do jogador
	
	-- Criar um novo ped limpo do mesmo modelo e depois clonar os componentes
	local newTestPed = CreatePed(26, GetEntityModel(Ped), resX, resY, resZ, Heading + 180.0, false, false)
	ClonePedToTarget(Ped, newTestPed)
	
	SetEntityCoordsNoOffset(newTestPed, resX, resY, resZ, false, false, false)
	SetEntityHeading(newTestPed, Heading + 180.0)
	SetEntityAsMissionEntity(newTestPed, true, true)
	SetBlockingOfNonTemporaryEvents(newTestPed, true)
	FreezeEntityPosition(newTestPed, true)
	SetEntityInvincible(newTestPed, true)
	SetEntityCollision(newTestPed, false, false)
	
	local weaponHash = GetSelectedPedWeapon(Ped)
	if weaponHash and weaponHash ~= `WEAPON_UNARMED` then
		GiveWeaponToPed(newTestPed, weaponHash, 255, false, true)
		SetCurrentPedWeapon(newTestPed, weaponHash, true)
	end
	
	table.insert(TestPeds, newTestPed)
	table.insert(TestPedsNetIds, false)
	TriggerEvent("Notify","Animação","Ped #"..#TestPeds.." criado! Use /moverped, /rempeds.","verde",5000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN TEST PED 2 CLI (ENTIDADE FÍSICA E REDE)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:spawnTestPed2Cli")
AddEventHandler("ayxlz_emotes:spawnTestPed2Cli", function()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Heading = GetEntityHeading(Ped)
	local ForwardVector = GetEntityForwardVector(Ped)
	local resX = Coords.x + (ForwardVector.x * 1.5)
	local resY = Coords.y + (ForwardVector.y * 1.5)
	local resZ = Coords.z -- Mantém a altura exata do jogador
	
	-- Criar um novo ped com isNetwork = true pra ser manipulado como entidade do servidor
	local newTestPed = CreatePed(26, GetEntityModel(Ped), resX, resY, resZ, Heading + 180.0, true, true)
	
	-- Garante que a entidade foi passada pro servidor primeiro e clona em rede
	NetworkRegisterEntityAsNetworked(newTestPed)
	local netId = ObjToNet(newTestPed)
	SetNetworkIdExistsOnAllMachines(netId, true)
	NetworkSetNetworkIdDynamic(netId, false)
	SetNetworkIdCanMigrate(netId, true)
	
	ClonePedToTarget(Ped, newTestPed)
	
	-- Garantir a roupa, tatuagens e maquiagens localmente via forçamento
	for i = 0, 11 do SetPedComponentVariation(newTestPed, i, GetPedDrawableVariation(Ped, i), GetPedTextureVariation(Ped, i), GetPedPaletteVariation(Ped, i)) end
	for i = 0, 7 do SetPedPropIndex(newTestPed, i, GetPedPropIndex(Ped, i), GetPedPropTextureIndex(Ped, i), true) end
	for i = 0, 12 do
		local success, overlayValue, colorType, firstColor, secondColor, overlayOpacity = GetPedHeadOverlayData(Ped, i)
		if success and overlayValue ~= 255 then
			SetPedHeadOverlay(newTestPed, i, overlayValue, overlayOpacity)
			SetPedHeadOverlayColor(newTestPed, i, colorType, firstColor, secondColor)
		end
	end
	SetPedHairColor(newTestPed, GetPedHairColor(Ped), GetPedHairHighlightColor(Ped))
	SetPedEyeColor(newTestPed, GetPedEyeColor(Ped))
	ClonePedToTarget(Ped, newTestPed)
	
	SetEntityCoordsNoOffset(newTestPed, resX, resY, resZ, false, false, false)
	SetEntityHeading(newTestPed, Heading + 180.0)
	SetBlockingOfNonTemporaryEvents(newTestPed, true)
	FreezeEntityPosition(newTestPed, true)
	
	local weaponHash = GetSelectedPedWeapon(Ped)
	if weaponHash and weaponHash ~= `WEAPON_UNARMED` then
		GiveWeaponToPed(newTestPed, weaponHash, 255, false, true)
		SetCurrentPedWeapon(newTestPed, weaponHash, true)
	end
	
	table.insert(TestPeds, newTestPed)
	table.insert(TestPedsNetIds, netId)
	TriggerEvent("Notify","Animação","Ped Físico #"..#TestPeds.." criado! Use /moverped, /rempeds.","verde",5000)

	-- Enviar as infos pro servidor sincronizar com todos da sessão
	local pedData = { components = {}, props = {}, overlays = {} }
	for i = 0, 11 do pedData.components[i] = {GetPedDrawableVariation(Ped, i), GetPedTextureVariation(Ped, i), GetPedPaletteVariation(Ped, i)} end
	for i = 0, 7 do pedData.props[i] = {GetPedPropIndex(Ped, i), GetPedPropTextureIndex(Ped, i)} end
	for i = 0, 12 do
		local success, overlayValue, colorType, firstColor, secondColor, overlayOpacity = GetPedHeadOverlayData(Ped, i)
		if success and overlayValue ~= 255 then
			pedData.overlays[i] = {overlayValue, colorType, firstColor, secondColor, overlayOpacity}
		end
	end
	pedData.hairColor = GetPedHairColor(Ped)
	pedData.hairHighlight = GetPedHairHighlightColor(Ped)
	pedData.eyeColor = GetPedEyeColor(Ped)
	pedData.coords = { x = resX, y = resY, z = resZ, h = Heading + 180.0 }

	TriggerServerEvent("ayxlz_emotes:syncPedAppearanceSvr", netId, GetPlayerServerId(PlayerId()), pedData)
end)

RegisterNetEvent("ayxlz_emotes:syncPedAppearanceCli")
AddEventHandler("ayxlz_emotes:syncPedAppearanceCli", function(netId, originalServerId, pedData)
	CreateThread(function()
		local timeout = 0
		while not NetworkDoesNetworkIdExist(netId) and timeout < 100 do
			Wait(100)
			timeout = timeout + 1
		end
		
		if NetworkDoesNetworkIdExist(netId) then
			local newTestPed = NetworkGetEntityFromNetworkId(netId)
			if DoesEntityExist(newTestPed) then
				FreezeEntityPosition(newTestPed, false)
				
				-- Tenta clonar do player original se ele estiver perto
				local cloned = false
				local originalPlayer = GetPlayerFromServerId(originalServerId)
				if originalPlayer ~= -1 then
					local originalPed = GetPlayerPed(originalPlayer)
					if DoesEntityExist(originalPed) then
						ClonePedToTarget(originalPed, newTestPed)
						cloned = true
					end
				end
				
				if not cloned and pedData then
					for i = 0, 11 do
						if pedData.components[i] then SetPedComponentVariation(newTestPed, i, pedData.components[i][1], pedData.components[i][2], pedData.components[i][3]) end
					end
					for i = 0, 7 do
						if pedData.props[i] then SetPedPropIndex(newTestPed, i, pedData.props[i][1], pedData.props[i][2], true) end
					end
					for i = 0, 12 do
						if pedData.overlays[i] then
							SetPedHeadOverlay(newTestPed, i, pedData.overlays[i][1], pedData.overlays[i][5])
							SetPedHeadOverlayColor(newTestPed, i, pedData.overlays[i][2], pedData.overlays[i][3], pedData.overlays[i][4])
						end
					end
					SetPedHairColor(newTestPed, pedData.hairColor, pedData.hairHighlight)
					SetPedEyeColor(newTestPed, pedData.eyeColor)
				end
				
				if pedData and pedData.coords then
					SetEntityCoordsNoOffset(newTestPed, pedData.coords.x, pedData.coords.y, pedData.coords.z, false, false, false)
					SetEntityHeading(newTestPed, pedData.coords.h)
				end
				FreezeEntityPosition(newTestPed, true)
			end
		end
	end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVE TEST PED CLI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:moveTestPedCli")
AddEventHandler("ayxlz_emotes:moveTestPedCli", function()
	if #TestPeds > 0 then
		local lastTestPed = TestPeds[#TestPeds]
		if DoesEntityExist(lastTestPed) then
			local Ped = PlayerPedId()
			
			if IsPedInAnyVehicle(Ped, false) then
				local vehicle = GetVehiclePedIsIn(Ped, false)
				local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
				local seated = false
				
				for i = 0, maxSeats - 2 do
					if IsVehicleSeatFree(vehicle, i) then
						SetPedIntoVehicle(lastTestPed, vehicle, i)
						TriggerEvent("Notify","Animação","O último ped criado foi colocado no banco de passageiro do veículo.","verde",5000)
						seated = true
						break
					end
				end
				
				if not seated then
					TriggerEvent("Notify","Animação","Nenhum assento livre encontrado no veículo para o ped.","vermelho",5000)
				end
			else
				local Coords = GetEntityCoords(Ped)
				local Heading = GetEntityHeading(Ped)
				
				SetEntityCoordsNoOffset(lastTestPed, Coords.x, Coords.y, Coords.z, false, false, false)
				SetEntityHeading(lastTestPed, Heading)
				
				TriggerEvent("Notify","Animação","O último ped criado foi movido para sua posição e direção atual.","verde",5000)
			end
		end
	else
		TriggerEvent("Notify","Animação","Nenhum ped teste spawnado no momento. Use /spawnped primeiro.","vermelho",5000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE PEDS CLI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:remTestPedsCli")
AddEventHandler("ayxlz_emotes:remTestPedsCli", function(pedId)
	if pedId then
		if TestPeds[pedId] then
			local netId = TestPedsNetIds[pedId]
			if netId then
				TriggerServerEvent("ayxlz_emotes:deletePedServer", netId)
			end
			if DoesEntityExist(TestPeds[pedId]) then
				DeleteEntity(TestPeds[pedId])
			end
			table.remove(TestPeds, pedId)
			table.remove(TestPedsNetIds, pedId)
			TriggerEvent("Notify","Animação","Ped #"..pedId.." deletado com sucesso.","verde",5000)
		else
			TriggerEvent("Notify","Animação","Ped #"..pedId.." não encontrado.","vermelho",5000)
		end
	else
		if #TestPeds > 0 then
			for idx, ped in ipairs(TestPeds) do
				local netId = TestPedsNetIds[idx]
				if netId then
					TriggerServerEvent("ayxlz_emotes:deletePedServer", netId)
				end
				if DoesEntityExist(ped) then
					DeleteEntity(ped)
				end
			end
			TestPeds = {}
			TestPedsNetIds = {}
			TriggerEvent("Notify","Animação","Todos os peds spawnados foram deletados.","verde",5000)
		else
			TriggerEvent("Notify","Animação","Nenhum ped teste spawnado no momento.","vermelho",5000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIM PED CLI (/animped)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:animPedCli")
AddEventHandler("ayxlz_emotes:animPedCli", function(emoteName)
	if #TestPeds > 0 then
		local lastTestPed = TestPeds[#TestPeds]
		if DoesEntityExist(lastTestPed) then
			local SelectedEmote = GetEmoteOnTable(emoteName)
			if SelectedEmote then
				ExecuteEmote(emoteName, lastTestPed, nil, false, true)
				TriggerEvent("Notify","Animação","Animando ped #"..#TestPeds.."!","verde",5000)
			else
				TriggerEvent("Notify","Animação","Animação não encontrada.","vermelho",5000)
			end
		end
	else
		TriggerEvent("Notify","Animação","Nenhum ped teste spawnado no momento. Use /spawnped primeiro.","vermelho",5000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIM PED COUPLE CLI (/animpedcouple)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ayxlz_emotes:animPedCoupleCli")
AddEventHandler("ayxlz_emotes:animPedCoupleCli", function(emoteName)
	if #TestPeds >= 2 then
		local ped1 = TestPeds[#TestPeds - 1]
		local ped2 = TestPeds[#TestPeds]
		
		if DoesEntityExist(ped1) and DoesEntityExist(ped2) then
			local SelectedEmote = GetEmoteOnTable(emoteName)
			if SelectedEmote and SelectedEmote.category == "shared" then
				local targetEmote = SelectedEmote.target_emote or emoteName
				
				-- Movendo Ped 1 pra perto do Ped 2 antes da anim
				local Coords = GetEntityCoords(ped2)
				local Heading = GetEntityHeading(ped2)
				SetEntityCoordsNoOffset(ped1, Coords.x, Coords.y, Coords.z, false, false, false)
				SetEntityHeading(ped1, Heading)
				
				-- Executando
				ExecuteEmote(emoteName, ped1, ped2, false, true)
				ExecuteEmote(targetEmote, ped2, ped1, false, true)
				
				TriggerEvent("Notify","Animação","Animando peds #"..(#TestPeds - 1).." e #"..#TestPeds.." em dupla!","verde",5000)
			else
				TriggerEvent("Notify","Animação","Não é uma animação compartilhada/válida.","vermelho",5000)
			end
		end
	else
		TriggerEvent("Notify","Animação","Apenas "..#TestPeds.." peds spawnados, são necessários 2. Use /spawnped novamente.","vermelho",5000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop", function(resourceName)
	if resourceName ~= GetCurrentResourceName() then return end
	
	local Ped = PlayerPedId()
	
	if #TestPeds > 0 then
		for idx, testPed in ipairs(TestPeds) do
			local netId = TestPedsNetIds[idx]
			if netId then
				TriggerServerEvent("ayxlz_emotes:deletePedServer", netId)
			end
			if DoesEntityExist(testPed) then
				SetEntityAsMissionEntity(testPed, true, true)
				DeleteEntity(testPed)
			end
		end
		TestPeds = {}
		TestPedsNetIds = {}
	end
	
	FreezeEntityPosition(Ped, false)
	
	if IsEntityAttached(Ped) then
		DetachEntity(Ped, true, true)
	end
	
	SetEntityCollision(Ped, true, true)
	
	if CurrentAnimation then
		if CurrentAnimation.category == "shared" then
			TriggerServerEvent("ayxlz_emotes:cancelShared")
		end
		
		if CurrentAnimation.dict == "Scenario" then
			ClearPedTasksImmediately(Ped)
			ClearAreaOfObjects(GetEntityCoords(Ped), 3.0, 0)
		else
			ClearPedTasks(Ped)
		end
		
		CurrentAnimation = nil
	end
	
	if PlayerProps and #PlayerProps > 0 then
		for _, prop in pairs(PlayerProps) do
			if DoesEntityExist(prop) then
				DeleteEntity(prop)
			end
		end
		PlayerProps = {}
	end
	
	if PlayerParticles and #PlayerParticles > 0 then
		for _, particle in pairs(PlayerParticles) do
			StopParticleFxLooped(particle, false)
		end
		PlayerParticles = {}
	end
	
	if ClonedPed and DoesEntityExist(ClonedPed) then
		DeleteEntity(ClonedPed)
		ClonedPed = nil
	end
	IsInPreview = false
	ShowPed = false
	
	if FakeProps then
		for _, prop in pairs(FakeProps) do
			if DoesEntityExist(prop) then
				DeleteEntity(prop)
			end
		end
		FakeProps = {}
	end
	
	if CurrentSharedTestPed and DoesEntityExist(CurrentSharedTestPed) then
		DetachEntity(CurrentSharedTestPed, true, true)
		ClearPedTasksImmediately(CurrentSharedTestPed)
		CurrentSharedTestPed = nil
	end
	
	SendNUIMessage({ action = 'display', status = false })
	SetNuiFocus(false, false)
	
	ClearFacialIdleAnimOverride(Ped)
	ResetPedMovementClipset(Ped, 0.2)
	
	SecondPropEmote = false
	TestAnimMode = false
	GlobalEmoteSequence = GlobalEmoteSequence + 1
end)