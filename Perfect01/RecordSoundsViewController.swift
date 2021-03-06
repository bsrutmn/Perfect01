//
//  RecordSoundsViewController.swift
//  Perfect01
//
//  Created by busra on 25.06.2018.
//  Copyright © 2018 busra. All rights reserved.
//


import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController ,AVAudioRecorderDelegate {
    var audioRecorder :AVAudioRecorder!

    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func recordAudio(_ sender: Any) {
        recordLabel.text = "Recording in progress"
        recordButton.isEnabled =  false
        stopRecordingButton.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordName = "recordedVoice.wav"
        let pathArray = [dirPath,recordName]
        let filePath = URL(string: pathArray.joined(separator:"/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        try!  audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled =  true
        stopRecordingButton.isEnabled = false
        recordLabel.text = "Tap to record "
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording")
        if flag {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    }
        else{
            print("Recording was not succesful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"  {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL =  sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispo}se of any resources that can be recreated.
    }


}

