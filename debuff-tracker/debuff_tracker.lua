_addon.author   = 'Gobbo, Project Tako';
_addon.name     = 'Debuff Tracker';
_addon.version  = '1.0';

require('common');

local default_config = 
{
	position = { 500, 500 },
	color = 0xFFFFFFFF,
	background_color = 0x40000000
};

local exConfig = default_config;

local debuff_data = 
{
	[23]  = { name = 'Dia', duration = 60, overwrites = { } },
	[24]  = { name = 'Dia II', duration = 120, overwrites = { 23, 33, 230 } },
	[25]  = { name = 'Dia III', duration = 90, overwrites = { 23, 24, 230, 231, 33 } },
	[33]  = { name = 'Diaga', duration = 60, overwrites = { } },
	[56]  = { name = 'Slow', duration = 120, overwrites = { } },
	[58]  = { name = 'Paralyze', duration = 120, overwrites = { } },
	[59]  = { name = 'Silence', duration = 120, overwrites = { } },
	[79]  = { name = 'Slow II', duration = 120, overwrites = { 56 } },
	[80]  = { name = 'Paralyze II', duration = 120, overwrites = { 58 } },
	[98]  = { name = 'Repose', duration = 90, overwrites = { 253 } },
	[220] = { name = 'Poison', duration = 90, overwrites = { } },
	[221] = { name = 'Poison II', duration = 120, overwrites = { 220, 225 } },
	[225] = { name = 'Poisonga', duration = 90, overwrites = { } },
	[230] = { name = 'Bio', duration = 60, overwrites = { 23, 33 } },
	[231] = { name = 'Bio II', duration = 120, overwrites = { 23, 24, 33 ,230 } },
	[232] = { name = 'Bio III', duration = 30, overwrites = { 23, 24, 33, 230, 231 } },
	[235] = { name = 'Burn', duration = 60, overwrites = { 236 } },	 --
	[236] = { name = 'Frost', duration = 60, overwrites = { 237 } }, --
	[237] = { name = 'Choke', duration = 60, overwrites = { 238 } }, -- These 6 spells I'm unsure of duration.  
	[238] = { name = 'Rasp', duration = 60, overwrites = { 239 } },	 -- They will be 60s until I confirm.
	[239] = { name = 'Shock', duration = 60, overwrites = { 240 } }, --
	[240] = { name = 'Drown', duration = 60, overwrites = { 235 } }, --
	[253] = { name = 'Sleep', duration = 60, overwrites = { } },
	[254] = { name = 'Blind', duration = 180, overwrites = { } },
	[255] = { name = 'Break', duration = 30, overwrites = { } },
	[259] = { name = 'Sleep II', duration = 120, overwrites = { 253, 273, 363, 576, 584, 598, 678 } },
	[273] = { name = 'Sleepga', duration = 90, overwrites = { } },
	[274] = { name = 'Sleepga II', duration = 120, overwrites = { 253, 273, 363, 576, 584, 598, 678 } },
	[276] = { name = 'Blind II', duration = 180, overwrites = { 254 } },
	[278] = { name = 'Geohelix', duration = 274, overwrites = { } },	    --
	[279] = { name = 'Hydrohelix', duration = 274, overwrites = { } },	--
	[280] = { name = 'Anemohelix', duration = 274, overwrites = { } },	--
	[281] = { name = 'Pyrohelix', duration = 274, overwrites = { } },	    -- Helix duration varies based on Job Points, Dark Arts, and Cape used.
	[282] = { name = 'Cryohelix', duration = 274, overwrites = { } },	    -- This is my duration under Dark Arts, Cape, and no Tabula Rasa.
	[283] = { name = 'Ionohelix', duration = 274, overwrites = { } },	    --
	[284] = { name = 'Noctohelix', duration = 274, overwrites = { } },	--
	[285] = { name = 'Luminohelix', duration = 274, overwrites = { } },   --
	[286] = { name = 'Addle', duration = 120, overwrites = { } },
	[319] = { name = 'Aisha: Ichi', duration = 120, overwrites = { } }, -- Don't know debuff duration
	[341] = { name = 'Jubaku: Ichi', duration = 90, overwrites = { } },
	[344] = { name = 'Hojo: Ichi', duration = 90, overwrites = { } },
	[345] = { name = 'Hojo: Ni', duration = 90, overwrites = { 344 } },
	[347] = { name = 'Kurayami: Ichi', duration = 90, overwrites = { } },
	[348] = { name = 'Kurayami: Ni', duration = 90, overwrites = { 347 } },
	[363] = { name = 'Sleepga', duration = 90, overwrites = { } },
	[364] = { name = 'Sleepga II', duration = 120, overwrites = { 253, 273, 363, 576, 584, 598, 678 } },
--	[156] = { name = 'Feint', duration = 30, overwrites = {} },
	[372] = { name = 'Gambit', duration = 92, overwrites = {} },
	[375] = { name = 'Rayke', duration = 47, overwrites = {} },
	[365] = { name = 'Breakga', duration = 30, overwrites = { } },
	[508] = { name = 'Yurin: Ichi', duration = 90, overwrites = { } },
    --  [561] = { name = 'Frightful Roar', duration = 180, overwrites = { } },
	[572] = { name = 'Sound Blast', duration = 180, overwrites = { } },
	[576] = { name = 'Yawn', duration = 90, overwrites = { } },
	[584] = { name = 'Sheep Song', duration = 60, overwrites = { } },
	[598] = { name = 'Soporific', duration = 90, overwrites = { } },
    --  [659] = { name = 'Demoralizing Roar', duration = 30, overwrites = { } },
    --  [660] = { name = 'Cimicine Discharge', duration = 90, overwrites = { } },
    	[678] = { name = 'Dream Flower', duration = 90, overwrites = { } },
	[703] = { name = 'Embalming Earth', duration = 180, overwrites = { } },
	[705] = { name = 'Foul Waters', duration = 180, overwrites = { 235, 719 } },
	[716] = { name = 'Nectarous Deluge', duration = 30, overwrites = { } },
	[719] = { name = 'Searing Tempest', duration = 60, overwrites = { } },
	[722] = { name = 'Entomb', duration = 60, overwrites = { } },
	[723] = { name = 'Saurian Slide', duration = 60, overwrites = { } },
    --  [724] = { name = 'Palling Salvo', duration = 90, overwrites = { 23, 33, 230 } },
	[726] = { name = 'Scouring Spate', duration = 180, overwrites = { } },
	[727] = { name = 'Silent Storm', duration = 300, overwrites = { } },
	[728] = { name = 'Tenebral Crush', duration = 90, overwrites = { } },
	[740] = { name = 'Tourbillion', duration = 60, overwrites = { } },
	[752] = { name = 'Cesspool', duration = 60, overwrites = { } },
	[753] = { name = 'Tearing Gust', duration = 60, overwrites = { } },
	[841] = { name = 'Distract', duration = 120, overwrites = { } },
	[842] = { name = 'Distract II', duration = 120, overwrites = { 841 } },
	[843] = { name = 'Frazzle', duration = 120, overwrites = { } },
	[844] = { name = 'Frazzle II', duration = 120, overwrites = { 843 } },
 	[882] = { name = 'Distract III', duration = 120, overwrites = { 841, 842 } },
 	[883] = { name = 'Frazzle III', duration = 120, overwrites = { 843, 844 } },
	[884] = { name = 'Addle II', duration = 120, overwrites = { 286 } },
	[885] = { name = 'Geohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },		--
	[886] = { name = 'Hydrohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	--
	[887] = { name = 'Anemohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	--
	[888] = { name = 'Pyrohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	 	-- Helix duration varies based on Job Points, Dark Arts, and Cape used.
	[889] = { name = 'Cryohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },		-- This is my duration under Dark Arts, Cape, and no Tabula Rasa.
	[890] = { name = 'Ionohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } },	 	--
	[891] = { name = 'Noctohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } }, 	--
	[892] = { name = 'Luminohelix II', duration = 274, overwrites = { 278, 279, 280, 281, 282, 283, 284, 285 } } 	--
    --  [502] = { name = 'Kaustra', duration = 0, overwrites = { } },
    --  [000] = { name = 'Spooky Holder', duration = 0, overwrites = { } },
}, { 'name', 'duration', 'overwrites' };

-- local job_debuff_data =
-- {
--	[156] = { name = 'Feint', duration = 30, overwrites = {} },
--	[372] = { name = 'Gambit', duration = 92, overwrites = {} },
--	[375] = { name = 'Rayke', duration = 47, overwrites = {} },
-- }, { 'name', 'duration', 'overwrites' };

local removal_data = 
{
	['sleep'] = { 98, 253, 259, 273, 274, 576, 584, 598, 678 },
	['poison'] = { 220, 221, 225, 716 },
	['Dia'] = { 23, 24, 25, 33 },
	['Bio'] = { 230, 231, 232 },
	['Helix'] = { 278, 279, 280, 281, 282, 283, 284, 285, 885, 886, 887, 888, 889, 890, 891, 892 },
	['paralysis'] = { 58, 80, 341 },
	['blindness'] = { 254, 276, 347, 348 },
	['silence'] = { 59, 727 },
	['petrification'] = { 255, 365, 722 },
	['slow'] = { 56, 79, 344, 345, 703 },
	['addle'] = { 286, 884 },
	['plague'] = { 752 },
	['STR Down'] = { },
	['DEX Down'] = { },
	['VIT Down'] = { },
	['AGI Down'] = { },
	['INT Down'] = { 572 },
	['MND Down'] = { },
	['CHR Down'] = { },
	['Burn'] = { 236, 719 },
	['Frost'] = { 237 },
	['Choke'] = { 238 },
	['Rasp'] = { 239 },
	['Shock'] = { 240 },
	['Drown'] = { 241, 705 },
	['Attack Down'] = { 319, 726 },
	['Defense Down'] = { 728, 740 },
--	['Magic Atk. Down'] = { },
	['Magic Def. Down'] = { 753 },
	['Inhibit TP'] = { 508 },
	['Gambit'] = { 372 },
	['Rayke'] = { 375 },
--	['Sepulcher'] = { },
--	['Arcane Crest'] = { },
--	['Hamanoha'] = { },
--	['Dragon Breaker'] = { },
--	['Intervene'] = { },
--	['Odyllic Subterfuge'] = { },
	['Evasion Down'] = { 841, 842, 882 },
	['Magic Evasion Down'] = { 843, 844, 883 }
};

local tracked_mobs = 
{
	
};

local helix_tier1 =
{

};

local helix_tier2 =
{

};

local spell_teirs =
{
	[23]  = 1,
	[24]  = 2,
	[25]  = 3,
	[230] = 1,
	[231] = 2,
	[232] = 3
};

local mob_dead = T{ 6, 20, 97, 406, 605, 646 };
local spell_fail = T{ 85, 284, 653, 655, 656 };
local spell_success = T{ 2, 230, 236, 237, 270, 277, 278, 279, 280, 266, 267, 268, 269, 271, 272, 320, 672 };
local spell_debuff = T{ 23, 24, 25, 33, 56, 58, 59, 79, 80, 98, 220, 221, 225, 230, 231, 232, 235, 236, 237, 238, 239, 240, 253, 254, 255, 259, 273, 274, 276, 286, 319, 341, 344, 345, 347, 348, 364, 365, 508, 572, 841, 842, 843, 844, 882, 883, 884,  };
--local song_debuff = T{ };
local blue_debuff = T{ 703, 705, 716, 719, 722, 723, 726, 727, 728, 740, 752, 753 };
local spell_debuff_status = T{ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 16, 18, 19, 20, 21, 31, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 147, 								148, 149, 168, 404, 562, 564, 536, 571 };
local spell_damage_debuff = T{ 23, 24, 25, 33, 230, 231, 232, 278, 279, 280, 281, 282, 283, 284, 285, 885, 886, 887, 888, 889, 890, 891, 892,
								703, 705, 716, 719, 722, 723, 726, 727, 728, 740, 752, 753 };
local helix1_debuff = T{ 278, 279, 280, 281, 282, 283, 284, 285 };
local helix2_debuff = T{ 885, 886, 887, 888, 889, 890, 891, 892 };
local job_debuff = T{320, 672}

---------------------------------------------------------------------------------------------------
-- func: load
-- desc: First called when our addon is loaded.
---------------------------------------------------------------------------------------------------
ashita.register_event('load', function()
	-- load the config
	exConfig = ashita.settings.load_merged(_addon.path .. 'settings/settings.json', exConfig);

	-- create our test on screen objects
	local f = AshitaCore:GetFontManager():Create('test-object');
	f:SetVisibility(true);
	f:SetPositionX(100);
	f:SetPositionY(100);
	
end);

---------------------------------------------------------------------------------------------------
-- func: command
-- desc: Called when our addon receives a command.
---------------------------------------------------------------------------------------------------
ashita.register_event('command', function(cmd, nType) 
	return false;
end);

---------------------------------------------------------------------------------------------------
-- func: incoming_packet
-- desc: Called when our addon receives an incoming packet.
---------------------------------------------------------------------------------------------------
ashita.register_event('incoming_packet', function(id, size, packet)
	
	local player = AshitaCore:GetDataManager():GetPlayer();
	local party = AshitaCore:GetDataManager():GetParty();
	local target = AshitaCore:GetDataManager():GetTarget();
	
if (id == 0x28) then
		local actor_id = struct.unpack('I', packet, 0x04 + 1);

		local target_count = struct.unpack('b', packet, 0x09 + 1);

		-- holds the bitOffset for unpacking bits
		local bitOffset = 82;

		-- unpack the action type
		-- 82 bits in. 0x0A:0x02 = 82
		-- action type is 4 bits wide
		local action_type = ashita.bits.unpack_be(packet, bitOffset, 4);
		-- adjust the offset
		bitOffset = bitOffset + 4;

		-- adjust the bitOffset
		bitOffset = bitOffset + 64;

		-- create our targets table, empty
		local targets = { };

		-- loop through how many targets there are
		for x = 1, target_count do
			-- empty target
			targets[x] = { };

			-- get the id of the target
			targets[x].id = ashita.bits.unpack_be(packet, bitOffset, 32);
			-- adjust the offset
			bitOffset = bitOffset + 32;

			-- get the action count
			targets[x].action_count = ashita.bits.unpack_be(packet, bitOffset, 4) + 1;
			-- adjust the offset
			bitOffset = bitOffset + 4;

			-- empty actions table
			targets[x].actions = { };

			-- loop through the action count
			for i = 1, targets[x].action_count do
				targets[x].actions[i] = { };
				-- get the targets reaction
				targets[x].actions[i].reaction = ashita.bits.unpack_be(packet, bitOffset, 5);
				-- adjust the offset
				bitOffset = bitOffset + 5;

				-- get the targets animation
				targets[x].actions[i].animation = ashita.bits.unpack_be(packet, bitOffset, 12);
				-- adjust the offset
				bitOffset = bitOffset + 12;

				-- get the targets special effect
				targets[x].actions[i].effect = ashita.bits.unpack_be(packet, bitOffset, 7);
				-- adjust the offset
				bitOffset = bitOffset + 7;

				-- get the targets knockback
				targets[x].actions[i].knockback = ashita.bits.unpack_be(packet, bitOffset, 3);
				-- adjust the offset
				bitOffset = bitOffset + 3;

				-- get the targets param
				-- use for damage debuffs (dia, bio, helix, blue magic)
				targets[x].actions[i].param = ashita.bits.unpack_be(packet, bitOffset, 17);
				-- adjust the offset
				bitOffset = bitOffset + 17;

				-- get the targets message id
				-- use for all normal debuffs (paralyze, slow, silence)
				targets[x].actions[i].message_id = ashita.bits.unpack_be(packet, bitOffset, 10);
				-- adjust the offset
				bitOffset = bitOffset + 10;

				-- adjust the offset manually
				bitOffset = bitOffset + 31;

				-- get if there is a subeffect. 0 = false 1 = true
				targets[x].actions[i].subeffect = ashita.bits.unpack_be(packet, bitOffset, 1);
				-- adjust the offset
				bitOffset = bitOffset + 1;

				-- check if there's a sub effect
				if (targets[x].actions[i].subeffect == 1) then
					-- get the targets add_effect
					targets[x].actions[i].add_effect = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;

					-- get the targets add_effect_param
					targets[x].actions[i].add_effect_param = ashita.bits.unpack_be(packet, bitOffset, 17);
					-- adjust the offset
					bitOffset = bitOffset + 17;

					-- get the targets add_effect_message
					targets[x].actions[i].add_effect_message = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;
				end

				-- get if there is a spikes. 0 = false 1 = true
				targets[x].actions[i].spikes = ashita.bits.unpack_be(packet, bitOffset, 1);
				-- adjust the offset
				bitOffset = bitOffset + 1;

				-- check if there's spikes
				if (targets[x].actions[i].spikes == 1) then
					-- get the targets spikes_effect
					targets[x].actions[i].spikes_effect = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;

					-- get the targets spikes_param
					targets[x].actions[i].spikes_param = ashita.bits.unpack_be(packet, bitOffset, 14);
					-- adjust the offset
					bitOffset = bitOffset + 17;

					-- get the targets spikes_message
					targets[x].actions[i].spikes_message = ashita.bits.unpack_be(packet, bitOffset, 10);
					-- adjust the offset
					bitOffset = bitOffset + 10;
				end
			end
		end

		for index,value in pairs(targets) do
			
			for k,v in pairs(spell_success) do
				if v == value.actions[1].message_id then

				end
			end

			print(value.actions[1].message_id);
			local f = AshitaCore:GetFontManager():Get('test-object');
			f:SetText(string.format('Action Message Id: %d | Sub Effect: %d', value.actions[1].message_id, value.actions[1].subeffect));
			
		end
	end
	return false;
end);



---------------------------------------------------------------------------------------------------
-- func: outgoing_packet
-- desc: Called when our addon receives an outgoing packet.
---------------------------------------------------------------------------------------------------
ashita.register_event('outgoing_packet', function(id, size, packet)
	return false;
end);

---------------------------------------------------------------------------------------------------
-- func: unload
-- desc: Called when our addon is unloaded.
---------------------------------------------------------------------------------------------------
ashita.register_event('unload', function()
	AshitaCore:GetFontManager():Delete('test-object');
end);