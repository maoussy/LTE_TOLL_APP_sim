#ifndef _TOLL_H
#define _TOLL_H


#include "inet/applications/base/ApplicationBase.h"
#include "inet/common/INETDefs.h"
#include "inet/common/lifecycle/NodeStatus.h"


class Tollbooth: public inet::IApp
{
protected:
    simsignal_t packetSentSignal;
    simsignal_t packetReceivedSignal;
    simsignal_t throughputSignal;
    simsignal_t delaySignal;

    int packetsSend;
    int packetsReceived;
    double  totalBytesSent;
    double  totalBytesReceived;
    simtime_t totalDelay;




    virtual void initialize(int stage) override;
    void virtual void handleMessageWhenup(cMessage *msg) override;
    virtual void finish() override;
    virtual bool isNodeUp();
};


#endif
