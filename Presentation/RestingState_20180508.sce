#write_codes = false; # switch true in lab!!!

active_buttons = 4;   
button_codes = 1,2,3,4;
default_all_responses = false;
response_port_output = false;
pulse_width = 20;

scenario_type = fMRI_emulation;
#scenario_type = fMRI;
pulse_code = 23;
pulses_per_scan = 1;
scan_period=2000;

default_background_color = 75,75,75;
default_text_color = 255,255,255;
default_text_align = align_center;
default_font = "Arial";
default_font_size = 0.6; # with definition of screen parameters, font size is relative to user defined units

screen_width_distance = 40; 
screen_height_distance = 11;
max_y = 5.5;

begin;

###########################################
###             Stimulation             ###
###########################################

text { caption = "Ende"; description = "end_now"; } end_text;

trial {
	trial_type = fixed;
	picture { text { caption = "Gleich geht's los"; description = "prepare"; }; x = 0; y = 0; };
	code = "prepare";
	duration = next_picture;
} instruction_trial;

trial {
	trial_type = fixed;
	picture { text { caption = "+"; description = "cross"; }; x = 0; y = 0; };
	code = "cross";
	port_code = 7;
	duration = 360000;
} restingstate_trial;

trial {
	trial_type = fixed;    
	picture { text end_text; x=0; y=0; };
	time = 0;
	code="end_now";
	port_code = 8;
	duration = 2000;
} end_trial;

begin_pcl;

term.print("ANLEITUNG VORLESEN:\n\nBitte halten Sie die Augen geöffnet\nund betrachten Sie das Kreuz, das in der Mitte des Bildschirms erscheint.\nSie müssen nichts weiter tun.\nDer Ruhe-Scan dauert 6 min.\n\n");
instruction_trial.present();

term.print("Waiting for Pulse = 5 ...\n");
loop until (pulse_manager.main_pulse_count() > 4) begin # Resting State starts with pulse=5
end;

term.print("display cross\n");
restingstate_trial.present();

end_trial.present();