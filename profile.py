"""OCT Alveo V80 profile with post-boot script
"""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
"""fpga 
"""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# We use the URN library below.
import geni.urn as urn
# Emulab extension
import geni.rspec.emulab

# Create a portal context.
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Pick your image.
imageList = ['urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD', 'UBUNTU 22.04', 'urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU24-64-STD', 'UBUNTU 24.04'] 

workflow = ['Vitis', 'Vivado']

toolVersion = ['2024.2', '2024.1'] 

pc.defineParameter("nodes","List of nodes",
                   portal.ParameterType.STRING,"",
                   longDescription="Comma-separated list of nodes (e.g., pc151,pc153). Please check the list of available nodes within the Mass cluster at https://www.cloudlab.us/cluster-status.php before you specify the nodes.")
                   
pc.defineParameter("workflow", "Workflow",
                   portal.ParameterType.STRING,
                   workflow[0], workflow,
                   longDescription="For Vitis application acceleration workflow, select Vitis. For traditional workflow, select Vivado.")   

pc.defineParameter("toolVersion", "Tool Version",
                   portal.ParameterType.STRING,
                   toolVersion[0], toolVersion,
                   longDescription="Select a tool version. It is recommended to use the latest version for the deployment workflow. For more information, visit https://www.xilinx.com/products/boards-and-kits/alveo/u280.html#gettingStarted")   
pc.defineParameter("osImage", "Select Image",
                   portal.ParameterType.IMAGE,
                   imageList[0], imageList,
                   longDescription="Supported operating systems are Ubuntu and CentOS.")  

                   
# Retrieve the values the user specifies during instantiation.
params = pc.bindParameters()        

# Check parameter validity.
  
pc.verifyParameters()

lan = request.LAN()

nodeList = params.nodes.split(',')
i = 0
for nodeName in nodeList:
    host = request.RawPC(nodeName)
    # UMass cluster
    host.component_manager_id = "urn:publicid:IDN+cloudlab.umass.edu+authority+cm"
    # Assign to the node hosting the FPGA.
    host.component_id = nodeName
    host.disk_image = params.osImage

    if params.workflow == "Vitis":
        cmd = "sudo /local/repository/post-boot-vitis.sh " + params.toolVersion + " >> /local/logs/output_log.txt"
    else:
        cmd = "sudo /local/repository/post-boot-vivado.sh " + params.toolVersion + " >> /local/logs/output_log.txt"

    host.addService(pg.Execute(shell="bash", command=cmd))
  
    i+=1

# Print Request RSpec
pc.printRequestRSpec(request)
