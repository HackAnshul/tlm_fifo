class driver extends uvm_component;
  trans trans_h;
  `uvm_component_utils(driver)
  uvm_blocking_get_port #(trans) drv_get_port;

  function new(string name ="driver", uvm_component parent);
    super.new(name,parent);
    drv_get_port=new("drv_get_port", this);
  endfunction
  task run_phase(uvm_phase phase);
    repeat(10) begin
      drv_get_port.get(trans_h);
      `uvm_info("driver",$sformatf("trans_h = %p",trans_h),UVM_MEDIUM)
    end
  endtask

endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  uvm_blocking_put_export #(trans) con_put_exp;
  //uvm_blocking_get_imp #(trans,consumer) con_get_imp;
  uvm_tlm_fifo #(trans) con_fifo;
  trans trans_h;
  driver drv_h;

  function new(string name="consumer", uvm_component parent);
    super.new(name,parent);
    con_put_exp = new("con_put_exp",this);
    //con_get_imp = new("con_get_imp",this);
  endfunction

  function void build_phase(uvm_phase phase);
    drv_h=driver::type_id::create("drv_h",this);
    con_fifo = new("con_fifo", this, 2);
  endfunction

  function void connect_phase (uvm_phase phase);
    con_put_exp.connect(con_fifo.put_export);
    drv_h.drv_get_port.connect(con_fifo.get_export);
  endfunction

  /*task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #50;
    phase.drop_objection(this);
  endtask*/
endclass
