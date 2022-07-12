# Mecanum Wheel Adaptor

<h1 align="center">
	<img width="853" src="https://github.com/dnkorte/mecanum_adaptor/blob/main/images/adaptors_and_wheels_853.jpg" alt="Picture of wheels and adaptors"><br>Sample Wheels and adaptors
</h1>


This project creates 3d-printable hub adaptors that mate DFRobotics Mecanum wheels to typical motor shafts used in hobby robotics -- 4mm, 5mm, and 6mm round shafts.

They are created in OpenSCAD, which is a text-based CAD tool that runs on Windows, Linux, and MAC (download it from https://openscad.org/ if you don't have it already).  Put the file provided here ("project_mecanum_wheel_adaptors.scad") in a folder on your computer, then open it in OpenSCAD.  Note that this tool is setup to use OpenSCAD's "customizer" feature to select the part you want, but this tool is hidden by default.  To show the customizer, just go to OpenSCAD's "View" menu and uncheck the "Hide Customizer" checkbox.

Once the customizer is visible you will see some dropdowns available (probably on the right side of your screen).  Select the "part" you want to create from the "part" dropdown (you can select the 4mm, 5mm, or 6mm version).  You may also select a "hub length" parameter that defines how long the adaptor is (wide tires will need longer adaptors than skinny tires), and the location for the "grub screws" that will help attach the adaptor to your motor shaft.

Whenever you change any of the dropdowns, it will redraw the image on screen.  When you have the adaptor as you wish it, click F6 or "Design/Render" on the menubar to make a finished render of the model, then select "File/Export" to save an .stl file for your printer.

The adaptor has a central hole at the "nut" end that is co-axial to the motor shaft -- this hole accepts an M3 screw to attach the adaptor to the wheel.  This hole is designed to be self-tapping for M3 bolts, but the ones that attach the adaptor to the axle can be selected as self-tapping or for use with threaded inserts.

If your printer tolerances are different than mine you may adjust the size of the screw holes or the shaft clearance holes by editing the project_12mm_hex_wheel_adaptors.scad file.  The relevant lines are 85-92; parameters are screwhole_radius_M30_passthru, screwhole_radius_M30_selftap, and axle_clearance_gap.

The image below shows the OpenSCAD screen.  Note the Customizer menu on the right side.

<h3 align="center">
	<img width="480" src="https://github.com/dnkorte/mecanum_adaptor/blob/main/images/openscad_mecanum_wheel_adaptor_thumb.jpg" alt="Picture of wheels and adaptors"><br>OpenSCAD screen
</h3>

The image below shows a closeup of the printed adaptor.
<h3 align="center">
	<img width="480" src="https://github.com/dnkorte/mecanum_adaptor/blob/main/images/closeup_adaptors_thumb.jpg" alt="closetup of adaptors"><br>Wheel mounted on adaptor
</h3>

A couple pre-built .stl files are included in the .stl folder here. Note that the hubs are best printed in the vertical orientation with shaft end down.  They should be printed fairly slowly for best results.  

The file shown does not include designs for the DFR 48mm wheels because i didn't have any to test it with, but the only difference would be the dimension of the hex portion that is inserted into the wheel.  

### DFR Mecanum Wheels Purchase Links</h3>
Just as an example, some of the wheels I have used are shown here
* 80 mm wheel : https://www.dfrobot.com/product-2042.html  
* 48 mm wheel : https://www.dfrobot.com/product-2041.html