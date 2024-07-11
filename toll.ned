//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package lte.simulations.toll;

//
// TODO auto-generated type
//
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.inet.AdhocHost;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.ethernet.Eth10G;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.eNodeB;
import lte.corenetwork.nodes.Ue;
import lte.common.LteNetworkConfigurator;
import org.car2x.veins.subprojects.veins_inet.VeinsInetManager;
import inet.applications.contract.IApp;





network TollcollectionNetwork
{
    parameters:
        double playgroundSizeX @unit(m);
        double playgroundSizeY @unit(m);
        double playgroundSizeZ @unit(m);
        @display("bgd=732,483;bgb=765,534");

    submodules:
        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        configurator: LteNetworkConfigurator {
            @display("p=50,120");
        }
        veinsManager: VeinsInetManager {
            @display("p=50,227;is=s");
        }
        channelControl: LteChannelControl {
            @display("p=50,25;is=s;");
        }
        binder: LteBinder {
            @display("p=50,175;is=s");
        }
        server: StandardHost {
            @display("p=660,136;is=n;i=device/server");
        }
        router: Router {
            @display("p=561,135;i=device/smallrouter");
        }
        pgw: PgwStandardSimplified {
            nodeType = "PGW";
            @display("p=462,136;is=l");
        }
        eNodeB1: eNodeB {
            @display("p=156,136;is=vl");
        }
        tollBooth: StandardHost {
            @display("p=246,233;is=n;i=device/laptop");

        }
        //tollApp: Tollbooth {
        //    @display("p=300,300;is=n;i=device/laptop");
        //}

    connections allowunconnected:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> eNodeB1.ppp;

       // tollApp.outt++<--> Eth10G <--> tollBooth.in;
        //tollApp.out --> tollBooth.radioIn[0];
}

