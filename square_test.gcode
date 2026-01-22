; Lowrider v4 Squaring Test Program
; This program marks four corners of a rectangle to test machine squareness
; After running, measure both diagonals - they should be equal if square
; Under 1mm difference is very good

; ========================================
; CONFIGURATION PARAMETERS - EDIT THESE
; ========================================
; Rectangle dimensions
#<x_size> = 600         ; X dimension in mm (adjust to your work area)
#<y_size> = 600         ; Y dimension in mm (adjust to your work area)

; Offset from home position
#<x_offset> = 50        ; X offset from home in mm
#<y_offset> = 50        ; Y offset from home in mm

; Z heights
#<safe_z> = 50           ; Safe Z height for traveling (mm)
#<touch_z> =  25         ; Z depth to touch/mark table (mm, negative = down)
#<touch_dwell> = 1      ; Dwell time at touch point (seconds)

; Feed rates
#<travel_feed> = 3000   ; Travel feed rate (mm/min)
#<plunge_feed> = 300    ; Plunge feed rate (mm/min)

; ========================================
; PROGRAM START
; ========================================

G21                     ; Set units to millimeters
G90                     ; Absolute positioning
G94                     ; Feed rate per minute

; Home the machine (comment out if already homed)
; G28                     ; Home all axes

; Move to safe Z height
G0 Z#<safe_z> F#<travel_feed>

; ========================================
; CORNER 1: Origin (X_offset, Y_offset)
; ========================================
G0 X#<x_offset> Y#<y_offset> F#<travel_feed>  ; Move to corner 1
G1 Z#<touch_z> F#<plunge_feed>                ; Lower to touch
G4 P#<touch_dwell>                              ; Dwell
G0 Z#<safe_z>                                   ; Raise to safe height

; ========================================
; CORNER 2: (X_offset + X_size, Y_offset)
; ========================================
#<corner2_x> = [#<x_offset> + #<x_size>]
G0 X#<corner2_x> Y#<y_offset> F#<travel_feed>  ; Move to corner 2
G1 Z#<touch_z> F#<plunge_feed>                ; Lower to touch
G4 P#<touch_dwell>                              ; Dwell
G0 Z#<safe_z>                                   ; Raise to safe height

; ========================================
; CORNER 3: (X_offset + X_size, Y_offset + Y_size)
; ========================================
#<corner3_x> = [#<x_offset> + #<x_size>]
#<corner3_y> = [#<y_offset> + #<y_size>]
G0 X#<corner3_x> Y#<corner3_y> F#<travel_feed> ; Move to corner 3
G1 Z#<touch_z> F#<plunge_feed>                ; Lower to touch
G4 P#<touch_dwell>                              ; Dwell
G0 Z#<safe_z>                                   ; Raise to safe height

; ========================================
; CORNER 4: (X_offset, Y_offset + Y_size)
; ========================================
#<corner4_y> = [#<y_offset> + #<y_size>]
G0 X#<x_offset> Y#<corner4_y> F#<travel_feed>  ; Move to corner 4
G1 Z#<touch_z> F#<plunge_feed>                ; Lower to touch
G4 P#<touch_dwell>                              ; Dwell
G0 Z#<safe_z>                                   ; Raise to safe height

; ========================================
; RETURN TO START
; ========================================
G0 X#<x_offset> Y#<y_offset> F#<travel_feed>   ; Return to origin corner
G0 Z#<safe_z>                                   ; Ensure safe Z height

M0                      ; Program end
