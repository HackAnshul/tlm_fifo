class stim extends uvm_component;

  trans trans_h;
  `uvm_component_utils(stim)
  uvm_blocking_put_port #(trans) stim_put_port;

  function new(string name="stim",uvm_component parent);
    super.new(name,parent);
    stim_put_port=new("stim_put_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    repeat(10) begin
      trans_h=new();
      assert(trans_h.randomize());
      `uvm_info("stim",$sformatf("trans_h = %p",trans_h),UVM_MEDIUM)
      stim_put_port.put(trans_h);
      #1;
    end
  endtask

endclass


class conv extends uvm_component;
  trans trans_h;
  `uvm_component_utils(conv)
  uvm_blocking_get_port #(trans) conv_get_port;

  uvm_blocking_put_port #(trans) conv_put_port;

  function new(string name="conv",uvm_component parent);
    super.new(name,parent);
    conv_get_port=new("conv_get_port",this);
    conv_put_port=new("conv_put_port",this);
  endfunction

  task run_phase (uvm_phase phase);
    repeat(10) begin
      conv_get_port.get(trans_h);
      //`uvm_info("sending",$sformatf("trans_h = %p",trans_h),UVM_MEDIUM)
      conv_put_port.put(trans_h);
      #1;
    end
  endtask

endclass


class producer extends uvm_component;
  `uvm_component_utils(producer)
  stim stim_h;
  conv conv_h;
  uvm_tlm_fifo #(trans) pro_fifo;

  uvm_blocking_put_port #(trans) pro_put_port;

  function new(string name="producer",uvm_component parent);
    super.new(name,parent);
    pro_put_port=new("pro_put_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    stim_h=stim::type_id::create("stim_h",this);
    conv_h=conv::type_id::create("conv_h",this);
    pro_fifo = new("pro_fifo", this, 2);
  endfunction

  function void connect_phase(uvm_phase phase);
    stim_h.stim_put_port.connect(pro_fifo.put_export);
    conv_h.conv_get_port.connect(pro_fifo.get_export);
    conv_h.conv_put_port.connect(pro_put_port);
  endfunction

  /*task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #50;
    phase.drop_objection(this);
  endtask*/
endclass
