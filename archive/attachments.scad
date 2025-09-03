// Developer: Atrox3D (Kevin Müller)
// Parametrische Staubsauger-Aufsätze
// Skalierung / Auflösung
$fn = $preview ? 64 : 128;

/* [Aufsatztyp] */
// Moegliche Werte: "adapter", "fugen_duese", "flach_duese", "buerste"
aufsatz_typ = "fugen_duese";

/* =================== Globale Parameter =================== */

/* [adapter] */
adapter_inlet_start_diameter = 32.1;
adapter_outled_end_diameter  = 25.1;
adapter_start_length         = 30.1;
adapter_end_length           = 30.1;
adapter_wall_thickness       = 1.6;

/* [fugen_duese] */
fugenD_inlet_start_diameter  = 32.1;
fugenD_outled_end_diameter   = 25.1;
fugenD_start_length          = 30.1;
fugenD_end_length            = 30.1;
fugenD_wall_thickness        = 1.6;
fugenD_end_angle             = 0.0;

/* [flach_duese] */
durchmesser_innen0 = 30.0;
laenge1 = 20.0;
laenge2 = 30.0;
wandstaerke = 1.6;
breite = 20.0;
laenge3 = 50.0;
winkel = 15.0;

/* [buerste] */
durchmesser_innen = 30.0;
laenge = 25.0;

/* =================== Dispatcher =================== */
if (aufsatz_typ == "adapter")
    adapter(adapter_inlet_start_diameter, adapter_outled_end_diameter, adapter_start_length, adapter_end_length, adapter_wall_thickness);

else if (aufsatz_typ == "fugen_duese")
    fugen_duese(fugenD_inlet_start_diameter, fugenD_start_length, fugenD_outled_end_diameter, fugenD_end_length, fugenD_wall_thickness, fugenD_end_angle);

else if (aufsatz_typ == "flach_duese")
    flach_duese(durchmesser_innen0, laenge1, laenge2, wandstaerke, breite, laenge3, winkel);

else if (aufsatz_typ == "buerste")
    buerste(durchmesser_innen, laenge, wandstaerke);

/* =================== Vormodule =================== */
module adapter_base(d_in_s, d_out_e, l_s, l_e, w){
    // Außenkörper
    union(){
        cylinder(h=l_s, d=d_in_s);
        translate([0,0,l_s-0.01]) cylinder(h=d_in_s-d_out_e, d1=d_in_s, d2=d_out_e);
        translate([0,0,l_s-0.1]) cylinder(h=l_e+0.1, d=d_out_e);
    }
}

/* =================== Endmodule =================== */
module adapter(d_in_s, d_out_e, l_s, l_e, w){
    difference(){
        adapter_base(d_in_s+2*w, d_out_e, l_s, l_e, w);
        translate([0,0,-0.1-w]) adapter_base(d_in_s, d_out_e-2*w, l_s, l_e+20, w);
    }
}

module fugen_duese(d_in_s, l_s, d_out_e, l_e, w, e_a){
    difference(){
        union(){
            cylinder(h=l_s, d=d_in_s);
            translate([0,0,l_s]) cylinder(d1=d_in_s, d2=d_out_e, h=l_e);
        }
        // Abschrägung über Rotationsschnitt
        translate([0,0,l_s+l_e+10]) rotate([0,e_a,0]) cube([50,50,20], center=true);
        // Bohrung innen
        translate([0,0,-0.1-w]) union(){
            cylinder(h=l_s, d=d_in_s-2*w);
            translate([0,0,l_s]) cylinder(d1=d_in_s-2*w, d2=d_out_e-2*w, h=l_e+5);
        }
    }
}

/* Simple Grundform für Flachdüse (Platzhalter, parametrisierbar) */
module flach_duese(d_in, l1, l2, w, b, l3, ang){
    difference(){
        union(){
            // Rund auf flach Übergang
            cylinder(h=l1, d=d_in+2*w);
            translate([0,0,l1]) hull(){
                circle(d=d_in+2*w);
                translate([b/2,0,0]) square([b, w*2], center=true);
            }
            translate([0,0,l1]) rotate([ang,0,0]) cube([b+2*w, (w*2)+10, l3], center=false);
        }
        // Innenkanal
        translate([0,0,-0.1-w]) union(){
            cylinder(h=l1+0.2, d=d_in);
            translate([0,0,l1]) hull(){
                circle(d=d_in);
                translate([b/2,0,0]) square([b, w], center=true);
            }
            translate([0,0,l1]) rotate([ang,0,0]) cube([b, w, l3+2], center=false);
        }
    }
}

/* Einfache Bürste als Grundkörper (ohne Borsten) */
module buerste(d_in, l, w){
    difference(){
        // Außenkörper
        union(){
            cylinder(h=l, d=d_in+2*w);
            translate([0,0,l]) cylinder(h=w*3, d=d_in+2*w+6);
        }
        // Innenbohrung
        translate([0,0,-0.1]) cylinder(h=l+w*3+0.2, d=d_in);
    }
}
