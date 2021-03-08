//
//  main.cpp
//  MIDIDemo
//
//  Created by Damon on 16/2/18.
//  Copyright © 2016年 Damon. All rights reserved.
//
//
//      ┏┛ ┻━━━━━┛ ┻┓
//      ┃　　　　　　 ┃
//      ┃　　　━　　　┃
//      ┃　┳┛　  ┗┳　┃
//      ┃　　　　　　 ┃
//      ┃　　　┻　　　┃
//      ┃　　　　　　 ┃
//      ┗━┓　　　┏━━━┛
//        ┃　　　┃   神兽 保佑
//        ┃　　　┃   代码无BUG！
//        ┃     ┃          -- Damon胡东东
//        ┃     ┃          -- http://hudongdong.com
//        ┃　　　┗━━━━━━━━━┓
//        ┃　　　　　　　    ┣┓
//        ┃　　　　         ┏┛
//        ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛
//          ┃ ┫ ┫   ┃ ┫ ┫
//          ┗━┻━┛   ┗━┻━┛
//


#include <iostream>
#include "MidiFile.h"
#include "Options.h"
#include <iomanip>
using namespace std;
int main(int argc, const char * argv[]) {
    //打印一个midi event的列表
    Options options;
    MidiFile midifile;
    //写文件的绝对路径
    midifile.read("/Users/Damon/Downloads/sss.mid");
    int tracks = midifile.getTrackCount();
    cout << "TPQ: " << midifile.getTicksPerQuarterNote() << endl;
    if (tracks > 1) {
        cout << "TRACKS: " << tracks << endl;
    }
    for (int track=0; track < tracks; track++) {
        if (tracks > 1) {
            cout << "\nTrack " << track << endl;
        }
        for (int event=0; event < midifile[track].size(); event++) {
            cout << dec << midifile[track][event].tick;
            cout << '\t' << hex;
            for (int i=0; i<midifile[track][event].size(); i++) {
                cout << (int)midifile[track][event][i] << ' ';
            }
            cout << endl;
        }
    }
    
    //多音道转换为单音道
    midifile.joinTracks();
    // midifile.getTrackCount() will now return "1", but original
    // track assignments can be seen in .track field of MidiEvent.
    
    cout << "TICK    DELTA   TRACK   MIDI MESSAGE\n";
    cout << "____________________________________\n";
    
    MidiEvent* mev;
    int deltatick;
    for (int event=0; event < midifile[0].size(); event++) {
        mev = &midifile[0][event];
        if (event == 0) {
            deltatick = mev->tick;
        } else {
            deltatick = mev->tick - midifile[0][event-1].tick;
        }
        cout << dec << mev->tick;
        cout << '\t' << deltatick;
        cout << '\t' << mev->track;
        cout << '\t' << hex;
        for (int i=0; i < mev->size(); i++) {
            cout << (int)(*mev)[i] << ' ';
        }
        cout << endl;
    }
    return 0;
}
