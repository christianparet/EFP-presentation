no_logfile = true;

default_background_color = 75,75,75;
default_text_color = 255, 255, 255;
default_text_align = align_center;
#default_font_size = 52;
default_font = "Arial";

screen_width_distance = 40;
screen_height_distance = 11;
max_y = 5.5;

begin;

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
   trial_duration = 100;
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
} graph_main;

begin_pcl;

int run = 1;

array <double> rest_values[30]={4.0,6.0,8.0,5.0,9.0,3.0,8.0,10.0,6.0,8.0,7.0,6.0,7.0,8.0,9.0,3.0,5.0,7.0,4.0,8.0,2.0,7.0,9.0,5.0,7.0,4.0,3.0,6.0,7.0,8.0};

double rest_mean = arithmetic_mean(rest_values);
double rest_std = population_std_dev(rest_values);

array <double> demo_values[30]={3.0,5.0,7.0,4.0,8.0,2.0,7.0,9.0,5.0,7.0,4.0,3.0,6.0,7.0,8.0,3.0,5.0,7.0,4.0,8.0,2.0,7.0,9.0,5.0,7.0,4.0,3.0,6.0,7.0,8.0};

int x_coord = -15;
double last_z = (rest_values[rest_values.count()]-rest_mean)/rest_std;
title.set_caption("Neurofeedback Block Nr. "+string(run));
title.redraw();

loop int i = 1 until i > demo_values.count() begin

	double z = (demo_values[i]-rest_mean)/rest_std; # current value is standardized relative to rest_values deviation

	line1.add_line( x_coord, last_z, x_coord+1, z );
	line1.redraw();

	graph_main.present();
	
	last_z = z;
	x_coord=x_coord+1;
	
	i=i+1;
	
end;

double demo_mean_raw = arithmetic_mean(demo_values);
double demo_mean = round((demo_mean_raw-rest_mean)/rest_std,2);

mean_line.add_line( -15, demo_mean, 15.5, demo_mean );
mean_line.redraw();
mean_score.set_caption("Score:\n"+string(demo_mean));
mean_score.set_font_color(255,255,255);
mean_score.redraw();
chart_pic.set_part_y(1,demo_mean);

graph_main.set_duration(10000);
graph_main.present();
