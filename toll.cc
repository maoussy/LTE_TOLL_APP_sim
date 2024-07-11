#include "toll.h"

Define_Module(Toll);

void Toll::initialize(int stage)
{
   ApplicationBase::initialize(stage);
   if (stage == inet::INITSTAGE_LOCAL){
       packetSentSignal = registerSignal("packetSent");
       packetReceivedSignal = registerSignal("packetReceived");
       throughputSignal = registerSignal("throughput");
       delaySignal = registerSignal("delay");

       packetsSent = 0;
       packetsReceived = 0;
       totalBytesSent = 0;
       totalBytesReceived = 0;
       totalDelay = 0;

   }
}

void Toll::handleMessageWhenUp(cMessage *msg)
{
    if (msg->isSelfMessage()){

    }
    else {
        emit(packetReceivedSignal, msg);
        packetReceived++;
        totalBytesReceived += check_and_cast<inet::Packet*>(msg)->getByteLength();

        simtime_t delay = simTime()-msg->getCreationTime();
        emit(delaySignal, delay);
        totalDelay +=delay;

        delete msg;
    }
}

void Toll::finish(){
    ApplicationBase::finish();

    recordScalar("packetsSent", packetsSent);
    recordScalar("packetsReceived", packetsReceived);
    recordScalar("totalBytesSent", totalBytesSent);
    recordScalar("totalBytesReceived", totalBytesReceived);
    recordScalar("totalDelay", totalDelay);
    updateThroughput();
}

bool Toll::isNodeup(){
    auto nodeStatus = dynamic_cast<inet::NodeStatus *>(findContainingNode(this)->getSubmodule("status"));
    return !nodeStatus || nodeStatus->getStates() == inet::NodeStatus::UP;
}

void Toll::updateThroughput()
{
    simtime_t simulationTime = simTime();
    double throughput = totalBytesReceived * 8 /SimulationTime.dbl();
    emit(throughputSignal, throughput);
    recordScalar("throughput", throughput);
}
