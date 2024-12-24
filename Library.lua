--- STEAMODDED HEADER
--- MOD_NAME: Library
--- MOD_ID: Library
--- PREFIX: lib
--- MOD_AUTHOR: [Foegro]
--- MOD_DESCRIPTION: a cryptid addon, that adds more code cards
--- BADGE_COLOUR: 12f254
--- DEPENDENCIES: [Talisman, Cryptid]
--- VERSION: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({
	key = "code_atlas",
	atlas_table = "ASSET_ATLAS",
	path = "code_atlas.png",
	px = 71,
	py = 95
})


SMODS.Consumable {
	set = "Code",
	name = "lib-library",
	key = "library",
	pos = { x = 0, y = 0 },
	config = { create = 2 },
	atlas = "code_atlas",
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.create } }
	end,
	can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.consumeable.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound("timpani")
						local _card = create_card("Code", G.consumeables, nil, nil, nil, nil, nil, "cry_automaton")
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						card:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
	end,
	cry_credits = {
		idea = {
			"Foegro"
		},
		art = {
			"Foegro"
		},
		code = {
			"Foegro"
		}
	},
}
SMODS.Consumable {
	set = "Code",
	name = "lib-temp",
	key = "temp",
	pos = { x = 1, y = 0 },
	config = { },
	atlas = "code_atlas",
	loc_vars = function(self, info_queue, card)
		return { }
	end,
	can_use = function(self, card)
		return G.jokers.config.card_limit - #G.jokers.cards >= 1 and #G.jokers.highlighted == 1
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			func = function()
				local card = copy_card(G.jokers.highlighted[1])
				card:add_to_deck()
				card:set_perishable(true)
				G.jokers:emplace(card)
				return true
			end,
		}))
	end,
	cry_credits = {
		idea = {
			"Foegro"
		},
		art = {
			"Foegro"
		},
		code = {
			"Foegro"
		}
	},
}

local aliases = {
	library = "://LIBRARY",
	lib = "://LIBRARY",
	temp = "://TEMP"
}

for k, v in pairs(aliases) do
	Cryptid.aliases[k] = v
end