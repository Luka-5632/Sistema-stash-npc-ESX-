
Config.NPCs = {
    {
        name = "Maurizio",
        model = "s_m_y_cop_01", 
        position = vec4(376.6903, -1097.7838, 38.2166 - 1, 351.5471), 
        items = { "phone", "police_cad", "burger" } 
    },
    {
        name = "John",
        model = "s_m_m_doctor_01",
        position = vec4(300.0, -600.0, 28.5, 45.0),
        items = { "medkit", "bandage", "water" }
    },
    {
        name = "MARIO",
        model = "s_m_m_doctor_01",
        position = vec4(297.4469, -520.8736, 42.2722, 191.0314),
        items = { "medkit", "bandage", "water" }
    },
}

Config.allowedJobs = { police = true, ems = true }
