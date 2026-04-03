-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAÇÕES CUSTOMIZADAS
-- Este arquivo é aberto para cadastro de novas animações sem precisar mexer no arquivo principal.
-- As animações cadastradas aqui serão mescladas automaticamente com as do arquivo principal.
--
-- Basta cadastrar no mesmo formato do arquivo principal:
--   ["nome"] = { category = "...", dict = "...", anim = "...", ... },
--
-- ═══════════════════════════════════════════════════════════════════════════
-- PROPRIEDADES:
-- ═══════════════════════════════════════════════════════════════════════════
--
-- category      → "normal", "dance", "shared", "expression", "walk"
-- dict          → Dicionário da animação
-- anim          → Nome da animação
-- hide          → Oculta do menu (útil para emotes _m que são contraparte de dupla)
-- walk          → Permite andar durante a animação
-- loop          → Animação fica em loop
-- stuck         → Fixa o ped no chão (não pode se mover)
-- cars          → Animação funciona dentro de veículos
-- weapon        → Permite usar com arma equipada
-- duration      → Duração em ms (padrão: -1 = infinito)
-- target_emote  → Nome do emote do parceiro (obrigatório para shared)
-- offset        → Posição relativa ao parceiro: { x, y, z, h }
-- attach        → Anexar ao parceiro: { bone, xPos, yPos, zPos, xRot, yRot, zRot }
-- prop          → Nome do modelo do prop (objeto na mão)
-- mao           → Bone ID da mão (28422 = mão direita, 60309 = mão esquerda)
--
-----------------------------------------------------------------------------------------------------------------------------------------

local CustomAnims = {

	["customdanca"] = { category = "dance", dict = "pfflytotokyo@animations", anim = "pfflytotokyoclip", walk = false, loop = true },




}


for name, data in pairs(CustomAnims) do
	AnimTable[name] = data
end
