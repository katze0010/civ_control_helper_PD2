local _upd_criminal_suspicion_progress_original = GroupAIStateBase._upd_criminal_suspicion_progress
function GroupAIStateBase:_upd_criminal_suspicion_progress(...)
	if self._ai_enabled then
		for obs_key, obs_susp_data in pairs(self._suspicion_hud_data or {}) do
			local unit = obs_susp_data.u_observer
			
			if managers.enemy:is_civilian(unit) then
				local waypoint = managers.hud._hud.waypoints["susp1" .. tostring(obs_key)]
				
				if waypoint then
					local color, arrow_color
					
					if unit:anim_data().drop then
						if not obs_susp_data._subdued_civ then
							obs_susp_data._alerted_civ = nil
							obs_susp_data._subdued_civ = true
							color = Color(0.264, 0.996, 0.756)
							arrow_color = Color(0.264, 0.996, 0.756)
						end
					end
					if color then
						waypoint.bitmap:set_color(color)
						waypoint.arrow:set_color(arrow_color:with_alpha(0.75))
					end
				end
			end
		end
	end
	return _upd_criminal_suspicion_progress_original(self, ...)
end
