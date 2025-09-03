// Parametrische Staubsauger-Aufsätze (OpenSCAD)
// Autor: Atrox3D
// Version: 1.0
// Lizenz: MIT
// Datum: 03.09.2025
// Beschreibung: Generator für Adapter, Fugendüsen, Flachdüsen und Bürstenaufsätze.
// Alle Maße sind parametrisierbar.

//Scaling
$fn = $preview ? 64 : 128;

/* [Düsentyp] */
//Was soll erzeugt werden? Moegliche Werte: "adapter", "fugen_duese", "flach_duese", "buerste"
aufsatz_typ = "flach_duese";

//Global Params

/* [adapter] */
adapter_inlet_start_diameter = 32.1;
adapter_outlet_end_diameter = 25.1;
adapter_start_length = 30.1;
adapter_end_length = 30.1;
adapter_wall_thickness = 1.6;

/* [fugen_duese] */
fugenD_inlet_start_diameter = 32.1;
fugenD_outlet_end_diameter = 15.1;
fugenD_start_length = 30.1;
fugenD_end_length = 30.1;
fugenD_wall_thickness = 1.6;
fugenD_end_angle = 0.0;

/* [flach_duese] */
flachD_inlet_start_diameter = 32.1;
flachD_outlet_end_diameter = 5.1;
flachD_start_length = 30.1;
flachD_end_length = 50.1;
flachD_wall_thickness = 1.6;
flachD_end_angle = 45;
flachD_breite = 50;

/* [Hidden] */
tiny_epsilon = 0.01;
cut_margin   = 0.1;

if (aufsatz_typ == "adapter")
    adapter(adapter_inlet_start_diameter, adapter_outlet_end_diameter, adapter_start_length,adapter_end_length, adapter_wall_thickness);


else if (aufsatz_typ == "fugen_duese")
    fugen_duese(fugenD_inlet_start_diameter, fugenD_start_length, fugenD_outlet_end_diameter, fugenD_end_length, fugenD_wall_thickness, fugenD_end_angle);


else if (aufsatz_typ == "flach_duese")
    flach_duese(flachD_inlet_start_diameter, flachD_start_length, flachD_end_length, flachD_wall_thickness, flachD_outlet_end_diameter, flachD_breite, flachD_end_angle);


//Vormodule
module adapter_base(d_in_s, d_out_e, l_s,l_e, w){
    union(){
        cylinder(h=l_s, d=d_in_s);
        translate([0,0,l_s-tiny_epsilon]) cylinder(h=d_in_s-d_out_e,d1=d_in_s,d2=d_out_e);
        translate([0,0,l_s-cut_margin]) cylinder(h=l_e+cut_margin, d=d_out_e);
        }
}

module fugen_duese_base(d_in_s, l_s, d_out_e, l_e, w, e_a){
    difference(){
        union(){
            cylinder(h=l_s, d=d_in_s);
            translate([0,0,l_s-tiny_epsilon]) cylinder(d1=d_in_s,d2=d_out_e,h=l_e);
            }
        }
}

//Endmodule
module adapter(d_in_s, d_out_e, l_s,l_e, w){
    difference(){
        adapter_base(d_in_s+2*w, d_out_e, l_s,l_e, w);
        translate([0,0,-cut_margin-w]) adapter_base(d_in_s, d_out_e-2*w, l_s,l_e+20);
        //cube([50,50,50]); //Innenansicht
    }
}

module fugen_duese(d_in_s, l_s, d_out_e, l_e, w, e_a){
    difference(){
        fugen_duese_base(d_in_s+w*2, l_s, d_out_e+w*2, l_e, w, e_a);
        translate([0,0,-cut_margin])fugen_duese_base(d_in_s, l_s, d_out_e, l_e+0.2, w, e_a);
        translate([0,0,l_s+l_e+10-e_a/10]) rotate([0,e_a,0]) cube([100,50,20],center =true);
        }
}

module flach_duese(d_in_s, l_s, l_e, w, b, l3, a){
        difference(){            
        union(){
            cylinder(h=l_s,d=d_in_s+w);
            hull(){
                translate([0,0,l_s])cylinder(h=1,d=d_in_s+w);
                translate([0,0,l_s+l_e]) cube([l3+w,b+w,cut_margin ],center=true);
            }
        }
        union(){
            translate([0,0,-cut_margin ]) cylinder(h=l_s+0.2,d=d_in_s);
            hull(){
                translate([0,0,l_s])cylinder(h=1,d=d_in_s);
                translate([0,0,l_s+l_e]) cube([l3,b,0.2],center=true);
                }
            }
            translate([0,0,l_s+l_e]) rotate([a,0,0]) cube([l3+w+1,b+w,200],center=true);
        }
}
