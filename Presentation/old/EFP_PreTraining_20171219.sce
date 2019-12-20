pcl_file = "EFP_PreTraining_20180104.pcl";
response_matching = simple_matching;

active_buttons = 4;   
button_codes = 1,2,3,4;
default_all_responses = true;

scenario_type = fMRI_emulation;
#scenario_type = fMRI;
pulse_code = 23;
pulses_per_scan = 1;
scan_period=800;

default_background_color = 75,75,75;
default_text_color = 255,255,255;
default_text_align = align_center;
default_font = "Arial";

screen_width_distance = 40; 
screen_height_distance = 11;
max_y = 5.5;

default_font_size = 0.5; # with definition of screen parameters, font size is relative to user defined units

begin;

###########################################
###             Stimulation             ###
###########################################

array {
LOOP $bar_nr 9;
	$bar = '$bar_nr + 1';
	bitmap { filename = "feedback$bar.png"; preload = true;};
ENDLOOP;
} bars;

array { 
	text { caption = "1"; alpha = -1; } ;
	text { caption = "2"; alpha = -1; } ;
	text { caption = "3"; alpha = -1; } ;
	text { caption = "4"; alpha = -1; } ;
} fingers;

bitmap { filename = "grey.png"; } bar;
text { caption = "+"; description = "5"; } plus;
text { caption = "Ende"; description = "end_now"; } end_text;

trial {
	trial_type = fixed;
	picture { text { caption = "Gleich geht's los"; description = "prepare"; }; x = 0; y = 0; };
	code = "prepare";
	duration = next_picture;
} instruction_trial;

trial {
	trial_type = fixed;
   stimulus_event {
      picture { bitmap bar; x = 0; y = 0; } feedback_pic;
      time = 0;
		duration = next_picture;
   } feedback_event;
} feedback_trial;

trial {
	trial_type = fixed;
   stimulus_event {
      picture { bitmap bar; x = 0; y = 0; };
      time = 0;
		duration = next_picture;
		code = "onset_rest_trial";
   } rest_event;
} rest_trial;

trial {
	trial_type = fixed;
	picture { text plus; x = -1; y = 0; text plus; x = 1; y = 0; } ft_picture;
	code = "onset_ft_trial";
	duration = next_picture;
} ft_trial;

trial {
	trial_type = fixed;    
	picture { text end_text; x=0; y=0; };
	time = 0;
	code="end_now";
	duration = 2000;
} end_trial;

###########################################
###                Chart                ###
###########################################

box {
    height = 8;
    width = 30.1;
    color = 255,255,255;
} frame;

box {
    height = 0.95;
    width = 30;
    color = 68,157,151;
} parcel;

line_graphic {
   line_width = 0.06;
	line_color = 10,80,255;
}line1;

line_graphic {
   line_width = 0.06;
	line_color = 225,146,78;
}mean_line;

trial {
	picture {		
		text {caption="mean"; font_size=0.25; font_color = 75,75,75;} mean_score; x = 17; y = 0;		
		text {caption="title"; font_size=0.25;} title; x = 0; y = 4.5;
		box frame; x = 0; y = 0;	
		text {caption="4"; font_size=0.25;}; x = -16; y = 4;
		text {caption="3"; font_size=0.25;}; x = -16; y = 3;
		text {caption="2"; font_size=0.25;}; x = -16; y = 2;
		text {caption="1"; font_size=0.25;}; x = -16; y = 1;
		text {caption="0"; font_size=0.25;}; x = -16; y = 0;
		text {caption="-1"; font_size=0.25;}; x = -16; y = -1;
		text {caption="-2"; font_size=0.25;}; x = -16; y = -2;
		text {caption="-3"; font_size=0.25;}; x = -16; y = -3;
		text {caption="-4"; font_size=0.25;}; x = -16; y = -4;		
		box parcel; x = 0; y = 3.5;
		box parcel; x = 0; y = 2.5;
		box parcel; x = 0; y = 1.5;
		box parcel; x = 0; y = 0.5;
		box parcel; x = 0; y = -3.5;
		box parcel; x = 0; y = -2.5;
		box parcel; x = 0; y = -1.5;
		box parcel; x = 0; y = -0.5;		
		line_graphic line1; x = 0; y = 0;
		line_graphic mean_line; x = 0; y = 0;			
	} chart_pic;	
	duration = next_picture;
} graph_main;

###########################################
###                Rating               ###
###########################################

array {
LOOP $pic 10;
	bitmap { filename = "scale$pic.jpg"; preload = true;};
ENDLOOP;
} scale;

bitmap{filename="scale0.jpg";preload=true;}scale_default_pic;
bitmap{filename="range_reg.jpg";preload=true;}range_reg_pic;
bitmap { filename = "reg_erfolg.jpg"; preload = true; }reg_erfolg_bm;
text { caption = "Mit unterer Taste bestätigen."; font_size = 0.25; } bestaetigen;

trial {                                  
   trial_type = first_response; 
	stimulus_event {
		picture { bitmap reg_erfolg_bm; x=0; y=1; bitmap scale_default_pic; x=0; y=0; bitmap range_reg_pic; x = 0; y = -0.5; text bestaetigen; x = 0; y = -2;}scale_default;
		time = 0;
		code="rating";
		duration = response;	
	} rating_event;
} rating_trial; 

# dss-4 rating:

bitmap{filename="range_dss.jpg";preload=true;}range_dss_pic;

trial {
   trial_duration = forever;
	trial_type = specific_response;   
	terminator_button= 3;
	picture { bitmap { filename = "DissoRating_Instruktion.png";} disso_instruction; x = 0; y = 0;}; 
	code = "Instruktion"; 
} inst_dss_trial;     

bitmap { filename = "dissoziation_depersonalisation.jpg"; preload = true; }dissoziation_depersonalisation_bm;
bitmap { filename = "dissoziation_derealisation.jpg"; preload = true; }dissoziation_derealisation_bm;
bitmap { filename = "dissoziation_hoeren.jpg"; preload = true; }dissoziation_hoeren_bm;
bitmap { filename = "dissoziation_analgesie.jpg"; preload = true; }dissoziation_analgesie_bm;
bitmap { filename = "entspannt.jpg"; preload = true; }entspannt_bm;

picture {bitmap dissoziation_depersonalisation_bm; x= 0; y = 1;} rating_pic;