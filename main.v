// ====================================================
// HoverTone – Acoustic Levitator FPGA Logic
// Generates 40 kHz square waves with optional phase shift
// Testing for 50 MHz input clock on Terasic DE10-Lite
// ====================================================

module HoverTone #(
    parameter integer NUM_CHANNELS = 4, // number of outputs
    parameter integer CLK_FREQ     = 50000000, // FPGA base clock (Hz)
    parameter integer OUT_FREQ     = 40000     // desired output frequency (Hz)
)(
    input  wire clk,     // 50 MHz system clock
    output reg [NUM_CHANNELS-1:0] out // ultrasonic outputs
);

    // Calculate half-period count for square wave
    localparam integer HALF_PERIOD = CLK_FREQ / (2 * OUT_FREQ);

    // Global counter
    reg [$clog2(HALF_PERIOD)-1:0] counter = 0;

    // Global tick for synchronization
    reg tick = 0;

    always @(posedge clk) begin
        if (counter >= HALF_PERIOD - 1) begin
            counter <= 0;
            tick <= ~tick; // toggle every half-period
        end else begin
            counter <= counter + 1;
        end
    end

    // ====================================================
    // Per-channel phase shift
    // phase_offset defines delay in ticks relative to tick
    // ====================================================
    // Example: for 90° phase shift at 40kHz, delay = HALF_PERIOD / 2
    // You can hardcode or make these configurable via registers

    reg [$clog2(HALF_PERIOD)-1:0] phase_offset [0:NUM_CHANNELS-1];

    integer i;
    initial begin
        // Example: 4 channels with different phases
        phase_offset[0] = 0;                   // 0°
        phase_offset[1] = HALF_PERIOD/4;       // 90°
        phase_offset[2] = HALF_PERIOD/2;       // 180°
        phase_offset[3] = (3*HALF_PERIOD)/4;   // 270°
    end

    // Channel counters
    reg [$clog2(HALF_PERIOD)-1:0] chan_count [0:NUM_CHANNELS-1];

    always @(posedge clk) begin
        for (i = 0; i < NUM_CHANNELS; i = i + 1) begin
            // increment each channel counter
            if (chan_count[i] >= HALF_PERIOD - 1) begin
                chan_count[i] <= 0;
                out[i] <= ~out[i]; // toggle output
            end else begin
                chan_count[i] <= chan_count[i] + 1;
            end
        end
    end

endmodule
